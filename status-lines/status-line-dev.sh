#!/bin/bash

# Developer-focused Status Line
CURRENT_DIR=$(pwd | sed "s|$HOME|~|")
TIME=$(date "+%H:%M:%S")

# Git info
GIT_INFO=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
    UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    AHEAD=$(git rev-list --count @{upstream}..HEAD 2>/dev/null 2>/dev/null || echo "0")
    BEHIND=$(git rev-list --count HEAD..@{upstream} 2>/dev/null 2>/dev/null || echo "0")

    GIT_INFO=" | 🌿 $BRANCH"
    [ "$UNCOMMITTED" -gt 0 ] && GIT_INFO="$GIT_INFO ($UNCOMMITTED)"
    [ "$AHEAD" -gt 0 ] && GIT_INFO="$GIT_INFO ↑$AHEAD"
    [ "$BEHIND" -gt 0 ] && GIT_INFO="$GIT_INFO ↓$BEHIND"
fi

# Project info
PROJECT_FILES=$(find . -maxdepth 1 -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.go" -o -name "*.java" 2>/dev/null | wc -l | tr -d ' ')
[ "$PROJECT_FILES" -gt 0 ] && PROJECT_INFO=" | 📁 $PROJECT_FILES files" || PROJECT_INFO=""

# Node.js version if package.json exists
NODE_INFO=""
if [ -f "package.json" ]; then
    NODE_VER=$(node --version 2>/dev/null || echo "")
    [ -n "$NODE_VER" ] && NODE_INFO=" | node $NODE_VER"
fi

echo "🔧 $TIME | $CURRENT_DIR$GIT_INFO$PROJECT_INFO$NODE_INFO"