#!/bin/bash

# File Change Logging for Agentic Development
# Logs file changes made during development

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.input.file_path // "unknown"')
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
SESSION_ID="${CLAUDE_SESSION_ID:-unknown}"

# Only log files in current project directory
if [[ "$FILE_PATH" == "$(pwd)"* ]]; then
    REL_PATH=$(echo "$FILE_PATH" | sed "s|$(pwd)/||")

    LOG_DIR="/Users/kidwiz404/.claude/file-changes"
    mkdir -p "$LOG_DIR"

    LOG_FILE="$LOG_DIR/changes-$(date "+%Y-%m-%d").jsonl"

    LOG_ENTRY="{
      \"timestamp\": \"$TIMESTAMP\",
      \"session_id\": \"$SESSION_ID\",
      \"file_path\": \"$REL_PATH\",
      \"action\": \"write\",
      \"project\": \"$(basename $(pwd))\"
    }"

    echo "$LOG_ENTRY" >> "$LOG_FILE"

    # Keep only last 30 days of file change logs
    find "$LOG_DIR" -name "changes-*.jsonl" -mtime +30 -delete 2>/dev/null
fi