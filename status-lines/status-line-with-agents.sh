#!/bin/bash

# Status Line with Subagent Tracking
# Shows current directory, git status, and active subagent information

# Get current working directory (shortened)
CURRENT_DIR=$(pwd | sed "s|$HOME|~|")
if [ ${#CURRENT_DIR} -gt 25 ]; then
    CURRENT_DIR="...$(echo $CURRENT_DIR | tail -c 22)"
fi

# Get current time
TIME=$(date "+%H:%M")

# Get git branch if in a git repo
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
    GIT_BRANCH=" 🌿 $GIT_BRANCH"
fi

# Check if there are uncommitted changes
GIT_STATUS=""
if [ -n "$GIT_BRANCH" ]; then
    if ! git diff --quiet 2>/dev/null || ! git diff --staged --quiet 2>/dev/null; then
        GIT_STATUS=" *"
    fi
fi

# Get current active subagent if available
SUBAGENT_INFO=""
TRACK_DIR="/Users/kidwiz404/.claude/subagent-tracking"
if [ -f "$TRACK_DIR/current-subagent.txt" ]; then
    CURRENT_SUBAGENT=$(cat "$TRACK_DIR/current-subagent.txt")
    CURRENT_TASK=$(cat "$TRACK_DIR/current-task.txt" 2>/dev/null || echo "working")
    LAST_USED=$(cat "$TRACK_DIR/last-used.txt" 2>/dev/null)

    # Only show if used within last 5 minutes
    if [ -n "$LAST_USED" ]; then
        LAST_TS=$(date -j -f "%Y-%m-%d %H:%M:%S" "$LAST_USED" +%s 2>/dev/null)
        CURRENT_TS=$(date +%s)
        DIFF=$((CURRENT_TS - LAST_TS))

        if [ $DIFF -lt 300 ]; then  # 5 minutes = 300 seconds
            SUBAGENT_INFO=" 🤖 $CURRENT_SUBAGENT"
        else
            # Clear old subagent info
            rm -f "$TRACK_DIR/current-subagent.txt" "$TRACK_DIR/current-task.txt" "$TRACK_DIR/last-used.txt"
        fi
    fi
fi

# Get available subagents count
SUBAGENT_COUNT=$(find ~/.claude/agents -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

# Combine all status elements
STATUS="[$TIME] $CURRENT_DIR$GIT_BRANCH$GIT_STATUS$SUBAGENT_INFO | $SUBAGENT_COUNT agents"

# Output the status line
echo "$STATUS"