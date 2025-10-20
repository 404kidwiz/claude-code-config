#!/bin/bash

# AI-focused Status Line
TIME=$(date "+%I:%M %p")
DIR_NAME=$(basename $(pwd))

# AI agents available
AGENTS_COUNT=$(find ~/.claude/agents -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
COMMANDS_COUNT=$(find ~/.claude/commands -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

# Model info
MODEL="GLM-4.6"

# Session info (if available)
SESSION_INFO=""
if [ -f ~/.claude/session.env ]; then
    SESSION_ID=$(grep SESSION_ID ~/.claude/session.env 2>/dev/null | cut -d'=' -f2 | tail -c 8)
    [ -n "$SESSION_ID" ] && SESSION_INFO=" | sess:$SESSION_ID"
fi

# Project context
CONTEXT_FILES=""
if [ -d ".claude" ]; then
    CONTEXT_FILES=" | 📋 Claude project"
fi

echo "🤖 AI: $MODEL | $DIR_NAME | $AGENTS_COUNT agents, $COMMANDS_COUNT cmds$SESSION_INFO$CONTEXT_FILES | $TIME"