#!/usr/bin/env python

import pathlib
import subprocess

# Requires the binary `bookmark`, it should be under zsh/bin

# Algorithm:
# - get opened sessions (with tmux-list-session)
# - get saved sessions (from the file ~/.bookmarks.data)
# - create a list with unique items from both lists (sorted)
# - ask to switch session with fzf
# - switch session

# NOTE: special chars replaced both here and in ~/.tmuxinator.yml
ESCAPE_BOOKMARK_CHARS = [
    # NOTE: if you change these characters also change zsh/bin/bookmark
    # NOTE: if you change these characters also change tmux/default-tmuxinator.yaml
    [".", "·"],
    [str(pathlib.Path.home()), "¬"],
]


def escape_session_name(v):
    for transform in ESCAPE_BOOKMARK_CHARS:
        v = v.replace(transform[0], transform[1])
    return v


def unescape_session_name(v):
    for transform in ESCAPE_BOOKMARK_CHARS:
        v = v.replace(transform[1], transform[0])
    return v


def format_session(name, opened):
    name = escape_session_name(name)
    out = " "
    if opened:
        out = "*"
    out += " | " + name
    return out


def cmd(args):
    cmd_run = subprocess.run(
        args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    return cmd_run


def find_closest_tmuxinator_file(path):
    pn = pathlib.Path(path)
    while pn != "/":
        if pn.joinpath(".tmuxinator.yml").is_file():
            return pn
        pn = pn.parent
    raise "Couldn't file a .tmuxinator.yml file anywhere in the tree"


def main():
    # List of sessions to display.
    sessions_to_display = []

    # List of sessions opened, they must be in canonical form.
    sessions_opened = []

    # Find list of sessions that are already opened and store them and their canonical form.
    opened_tmux_sessions = cmd(["tmux", "list-sessions", "-F", "#{session_name}"])
    opened_tmux_sessions = sorted(opened_tmux_sessions.stdout.strip().split("\n"))
    for session in opened_tmux_sessions:
        # sessions that come from tmux were already transformed to a format that tmuxinator understands.
        # therefore we need to find their canonical form.
        canonical_session = unescape_session_name(session)
        if canonical_session not in sessions_opened:
            sessions_to_display.append(format_session(canonical_session, opened=True))
            sessions_opened.append(canonical_session)

    # Add sessions obtained from the `bookmark` bash script.
    all_bookmarks = cmd(["bookmark", "--list"])
    all_bookmarks = sorted(all_bookmarks.stdout.strip().split("\n"))
    for bookmark in all_bookmarks:
        # bookmarks are always in canonical form.
        # only push if it's not opened (if it's opened then it was pushed before)
        if bookmark not in sessions_opened:
            sessions_to_display.append(format_session(bookmark, opened=False))
            sessions_opened.append(bookmark)

    # Call fzf with the sessions.
    chosen = cmd(
        [
            "bash",
            "-c",
            "echo '{}' | fzf-tmux -d 15".format("\n".join(sessions_to_display)),
        ],
    )
    chosen = chosen.stdout.strip()
    if len(chosen) == 0:
        exit(0)

    c_opened, c_name_encoded = chosen.split("|")
    c_name = unescape_session_name(c_name_encoded.strip())
    c_name_encoded = c_name_encoded.strip()

    # The session chosen is opened in tmux so switch to it
    if len(c_opened) > 0:
        switch_cmd = cmd(["tmux", "switch-client", "-t", c_name_encoded])
        if switch_cmd.returncode != 0:
            raise ValueError(
                f"Failed to switch to {c_name_encoded}: {switch_cmd.stderr}"
            )
        exit(0)
    else:
        # The session chosen is bookmarked but not opened yet.
        closest_dir = find_closest_tmuxinator_file(c_name)
        if closest_dir is None:
            raise ValueError(f".tmuxinator.yml file not found in ancestors of {c_name}")

        # Make sure that the bookmark is still valid.
        list_files_in_bookmark = cmd(["bash", "-c", f"ls '{c_name}' > /dev/null"])
        if list_files_in_bookmark.returncode != 0:
            raise ValueError(
                f"failed to list files in bookmark={c_name}: {list_files_in_bookmark.stderr}"
            )

        # Verify if we need to symlink a root ~/.tmuxinator.yml to the target session to open.
        needs_symlink = False
        if closest_dir != c_name:
            needs_symlink = True

        # If we need to symlink then create the symlink.
        if needs_symlink:
            cmd(
                [
                    "bash",
                    "-c",
                    f"cd '{c_name}' && ln -s '{pathlib.Path(closest_dir).joinpath('.tmuxinator.yml')}' .tmuxinator.yml",
                ]
            )

        # Make sure that the symlink was created successfully in the target directory.
        list_tmuxinator_file_in_bookmark = cmd(
            [
                "bash",
                "-c",
                f"cd {c_name} && ls .tmuxinator.*  > /dev/null 2>&1",
            ]
        )
        if list_tmuxinator_file_in_bookmark.returncode != 0:
            raise ValueError(
                f"failed to list files in bookmark={c_name}: {list_tmuxinator_file_in_bookmark.stderr}"
            )

        # start tmuxinator at the directory.
        # NOTE: At some point I wanted to use tmuxp, I didn't use because in my ~/.tmuxinator.yml
        # I use ruby interpolations which I can't do in tmuxp.
        run_tmuxinator = cmd(["bash", "-c", f"cd '{c_name}' && tmuxinator start ."])
        if run_tmuxinator.returncode != 0:
            raise ValueError(
                f"failed to run tmuxinator at {c_name}: {run_tmuxinator.stderr}"
            )

        # If we created a symlink before then we need to remove it because it was temporary.
        if needs_symlink:
            cmd(["bash", "-c", f"cd '{c_name}' && trash .tmuxinator.yml"])


main()

# vim: set ft=python
