#!/usr/bin/env python

import pathlib
import subprocess
import os

# Requires the binary `bookmark`, it should be under zsh/bin

# Algorithm:
# - get saved sessions (from the file ~/.bookmarks.data)
# - get opened sessions (with zellij list-sessions)
# - create a list with unique items from both lists (sorted)
# - ask to switch session with fzf
# - switch session

def format_session(name, opened, path):
    out = " "
    if opened:
        out = "*"
    out += " | " + name
    out += " | " + path
    return out


def cmd(args):
    # print("cmd:", args)
    cmd_run = subprocess.run(
        args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    return cmd_run


def find_closest_zellij_file(path):
    pn = pathlib.Path(path)
    while pn != pathlib.Path("/"):
        if pn.joinpath(".zellij.kdl").is_file():
            return pn
        pn = pn.parent
    return None


def get_opened_sessions():
    all_sessions = cmd(["zellij", "list-sessions", "-n"])
    opened_sessions = []
    for str in all_sessions.stdout.split("\n"):
        if not str:
            continue
        if "EXITED" in str:
            continue
        opened_sessions.append(str.split()[0])
    return opened_sessions


def main():
    # List of sessions to display.
    sessions_to_display = []

    # Add sessions obtained from the `bookmark` bash script.
    all_bookmarks = cmd(["bookmark", "--list"])
    all_bookmarks = sorted(all_bookmarks.stdout.strip().split("\n"))
    for bookmark in all_bookmarks:
        bookmark_basename = os.path.basename(bookmark.strip())
        sessions_to_display.append(
            format_session(bookmark_basename, opened=False, path=bookmark)
        )

    # List of sessions opened, they must be in canonical form.
    opened_zellij_sessions = get_opened_sessions()

    # Find list of sessions that are already opened and store them and their canonical form.
    for opened_session in opened_zellij_sessions:
        found = False
        found_index = -1
        for index, item in enumerate(sessions_to_display):
            if opened_session in item:
                found = True
                found_index = index
                break

        if found:
            to_move = sessions_to_display.pop(found_index)
            sessions_to_display.insert(0, to_move)

        if not found:
            sessions_to_display.insert(
                0, format_session(opened_session, opened=False, path="")
            )

    # Call fzf with the sessions.
    chosen = cmd(
        [
            "bash",
            "-c",
            "echo '{}' | fzf".format("\n".join(sessions_to_display)),
        ]
        # [
        #     "bash",
        #     "-c",
        #     # "zellij run -f -- echo '{}' | fzf".format("\n".join(sessions_to_display)),
        #     "fzf",
        # ],
    )
    chosen = chosen.stdout.strip()
    if len(chosen) == 0:
        exit(0)

    c_opened, c_name, c_path = chosen.split("|")
    switch_cmd = cmd(
        [
            "zellij",
            "pipe",
            "--plugin",
            "https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm",
            "--",
            f"--session {c_name} --cwd {c_path} --layout default",
            # "-c",
            # f'zellij pipe --plugin https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm -- "--session {c_basename} --cwd {c_absolute} --layout default"',
        ]
    )
    if switch_cmd.returncode != 0:
        raise ValueError(f"Failed to switch to {c_name}: {switch_cmd.stderr}")
    exit(0)

    # The session chosen is opened in tmux so switch to it
    # if len(c_opened) > 0:
    #     switch_cmd = cmd(
    #         [
    #             "bash",
    #             "-c",
    #             f'zellij pipe --plugin https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm -- "--session {c_basename} --cwd {c_name} --layout default"',
    #         ]
    #     )
    #     if switch_cmd.returncode != 0:
    #         raise ValueError(
    #             f"Failed to switch to {c_basename}: {switch_cmd.stderr}"
    #         )
    #     exit(0)
    # else:
    #     # Make sure that the bookmark is still valid.
    #     list_files_in_bookmark = cmd(["bash", "-c", f"ls '{c_name}' > /dev/null"])
    #     if list_files_in_bookmark.returncode != 0:
    #         raise ValueError(
    #             f"failed to list files in bookmark={c_name}: {list_files_in_bookmark.stderr}"
    #         )
    #
    #     # The session chosen is bookmarked but not opened yet.
    #     closest_dir = find_closest_zellij_file(c_name)
    #     # Verify if we need to symlink a root ~/.zellij.layout.kld to the target session to open.
    #     needs_symlink = False
    #     if closest_dir is None:
    #         needs_symlink = True
    #
    #     # If we need to symlink then create the symlink.
    #     if needs_symlink:
    #         cmd(
    #             [
    #                 "bash",
    #                 "-c",
    #                 f"cd '{c_name}' && ln -s ~/.config/zellij/layouts/example.kdl .layout.kdl",
    #             ]
    #         )
    #
    #     # Make sure that the symlink was created successfully in the target directory.
    #     list_layout_file_in_bookmark = cmd(
    #         [
    #             "bash",
    #             "-c",
    #             f"cd {c_name} && ls .layout.kdl  > /dev/null 2>&1",
    #         ]
    #     )
    #     if list_layout_file_in_bookmark.returncode != 0:
    #         raise ValueError(
    #             f"failed to list files in bookmark={c_name}: {list_layout_file_in_bookmark.stderr}"
    #         )
    #
    #     # start zellij at the directory.
    #     run_zellij = cmd(
    #         [
    #             "bash",
    #             "-c",
    #             f'zellij pipe --plugin https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm -- "--session {c_basename} --cwd {c_name} --layout default"',
    #         ]
    #     )
    #     if run_zellij.returncode != 0:
    #         raise ValueError(f"failed to run zellij at {c_name}: {run_zellij.stderr}")
    #
    #     # If we created a symlink before then we need to remove it because it was temporary.
    #     if needs_symlink:
    #         cmd(["bash", "-c", f"cd '{c_name}' && trash .layout.kdl"])


main()

# vim: set ft=python
