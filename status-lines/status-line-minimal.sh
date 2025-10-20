#!/bin/bash

# Minimal Status Line - Clean and Simple
TIME=$(date "+%H:%M")
CURRENT_DIR=$(basename $(pwd))
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    GIT_BRANCH=" $(git branch --show-current 2>/dev/null | head -c 10)"
fi

echo "$TIME $CURRENT_DIR$GIT_BRANCH"