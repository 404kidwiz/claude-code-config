#!/bin/bash

# Claude Code Custom Status Line Script
# This script generates a dynamic status line for Claude Code

# Get current working directory (shortened)
CURRENT_DIR=$(pwd | sed "s|$HOME|~|")
if [ ${#CURRENT_DIR} -gt 30 ]; then
    CURRENT_DIR="...$(echo $CURRENT_DIR | tail -c 27)"
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

# Get available subagents count
SUBAGENT_COUNT=$(find ~/.claude/agents -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
SUBAGENTS=" 🤖 $SUBAGENT_COUNT agents"

# Get current model if available
MODEL="GLM-4.6"
MODEL_INFO=" 🧠 $MODEL"

# Get memory usage if available (macOS)
MEMORY=""
if command -v vm_stat > /dev/null 2>&1; then
    FREE_MEM=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
    if [ -n "$FREE_MEM" ]; then
        MEMORY=" 💾 ${FREE_MEM}MB free"
    fi
fi

# Combine all status elements
STATUS="[$TIME] $CURRENT_DIR$GIT_BRANCH$GIT_STATUS$SUBAGENTS$MODEL_INFO$MEMORY"

# Output the status line
echo "$STATUS"