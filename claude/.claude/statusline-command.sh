#!/bin/bash
# Status line for Claude Code.
#
# Line 1: current directory (abbreviated with ~) and [branch glyph + name] on
#         the left, weekly usage percentage pushed to the right.
# Line 2: model name, effort level, and context usage percentage in the form
#         "(XX%)", right-aligned on its own line.

# Read the status line JSON payload from stdin.
input=$(cat)

# Extract the display name of the active model.
modelName=$(echo "$input" | jq -r '.model.display_name')

# Extract the current working directory and keep an unabbreviated copy for git.
rawDirectory=$(echo "$input" | jq -r '.workspace.current_dir')
displayDirectory="$rawDirectory"

# Abbreviate the home directory prefix with '~'.
case "$displayDirectory" in
    "$HOME"/*) displayDirectory="~${displayDirectory#"$HOME"}" ;;
    "$HOME") displayDirectory="~" ;;
esac

# Extract the current git branch, skipping optional locks to avoid contention.
branchName=$(git -C "$rawDirectory" --no-optional-locks branch --show-current 2>/dev/null)

# Extract the model reasoning effort level, if available.
effortLevel=$(echo "$input" | jq -r '.effort.level // empty')

# Extract the weekly and context usage percentages, if available.
weeklyPercentage=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
contextPercentage=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build the left-hand side: directory followed by a branch glyph and name when available.
leftText="$displayDirectory"
[ -n "$branchName" ] && leftText="$leftText [⎇ $branchName]"

# Build the right-hand side: weekly usage percentage only (context usage moves
# next to the model name on the second line).
rightText=""
if [ -n "$weeklyPercentage" ]; then
    rightText="Weekly quota: $(printf '%.0f' "$weeklyPercentage")%"
fi

# Terminal width for right-alignment.
#
# As of Claude Code v2.1.153+, $COLUMNS (and $LINES) is documented to be set
# by Claude Code to the actual current terminal width before the statusLine
# command is invoked, so it can be read directly as an inherited environment
# variable. This is the officially supported mechanism for this purpose.
#
# Do not reintroduce /dev/tty probing (stty size / tput cols) or ANSI
# cursor-movement escapes (e.g. "\033[9999C\033[ND") for right-alignment:
# both were tried previously and failed, because the statusLine command has
# no controlling terminal to probe, and because Claude Code captures the
# script's stdout as a plain text string rather than passing it through to
# the real terminal raw, so cursor-movement escapes are not honored.
terminalWidth="$COLUMNS"
case "$terminalWidth" in
    ''|*[!0-9]*) terminalWidth=80 ;;
esac

# Claude Code reserves a few columns on the right edge of the status line
# area, so the usable width is narrower than the full terminal width that
# $COLUMNS reports. Measured empirically with a column-ruler calibration:
# on a 174-column terminal the rightmost visible column was 170, i.e. a
# 4-column reserve. Subtracting it keeps right-aligned text flush with the
# last *visible* column instead of overshooting, which previously trimmed
# line 1's right text and wrapped line 2 (making it look left-aligned).
statusLineRightReserve=4
terminalWidth=$((terminalWidth - statusLineRightReserve))
[ "$terminalWidth" -lt 1 ] && terminalWidth=1

# Build the first line: left text, then enough spaces to push the
# right-hand text flush against the last column. Fall back to a single
# separating space if the combined text is already at or beyond the
# terminal width, so the padding count is never negative.
firstLine="$leftText"
if [ -n "$rightText" ]; then
    firstLinePadding=$((terminalWidth - ${#leftText} - ${#rightText}))
    [ "$firstLinePadding" -lt 1 ] && firstLinePadding=1
    firstLine="$leftText$(printf '%*s' "$firstLinePadding" '')$rightText"
fi

# Build the second line: model name, effort level, then context usage.
modelText="$modelName"
[ -n "$effortLevel" ] && modelText="$modelText $effortLevel"
[ -n "$contextPercentage" ] && modelText="$modelText ($(printf '%.0f' "$contextPercentage")%)"

# Right-align the model text on its own second line, using the same width
# basis as line 1. Never pad with a negative count.
#
# Claude Code trims leading whitespace from each rendered status-line row, so
# line 1 (which pads in the middle: left + spaces + right) aligns correctly
# but naive leading padding here (spaces + text) gets stripped, dropping the
# model text back to the left edge. Prefix the padding with a zero-width space
# (U+200B) sentinel: the row then no longer *starts* with whitespace, so the
# trim leaves the following spaces intact, while the sentinel itself renders
# invisibly and occupies no display column (alignment stays flush-right).
zeroWidthSpace=$'​'
secondLinePadding=$((terminalWidth - ${#modelText}))
[ "$secondLinePadding" -lt 0 ] && secondLinePadding=0
secondLine="$zeroWidthSpace$(printf '%*s' "$secondLinePadding" '')$modelText"

printf '%s\n%s' "$firstLine" "$secondLine"
