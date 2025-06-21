#!/usr/bin/env python

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
    cmd_run = subprocess.run(
        args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    return cmd_run


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
        ]
    )
    if switch_cmd.returncode != 0:
        raise ValueError(f"Failed to switch to {c_name}: {switch_cmd.stderr}")
    exit(0)


main()

# vim: set ft=python
