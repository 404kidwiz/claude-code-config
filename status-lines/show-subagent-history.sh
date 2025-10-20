#!/bin/bash

# Show Subagent Usage History
# This script displays recent subagent usage

TRACK_DIR="/Users/kidwiz404/.claude/subagent-tracking"

echo "🤖 Recent Subagent Usage:"
echo "========================"

# Show current active subagent if any
if [ -f "$TRACK_DIR/current-subagent.txt" ]; then
    CURRENT_SUBAGENT=$(cat "$TRACK_DIR/current-subagent.txt")
    CURRENT_TASK=$(cat "$TRACK_DIR/current-task.txt" 2>/dev/null || echo "working")
    LAST_USED=$(cat "$TRACK_DIR/last-used.txt" 2>/dev/null)

    echo "🔴 Currently Active: $CURRENT_SUBAGENT"
    echo "📝 Task: $CURRENT_TASK"
    if [ -n "$LAST_USED" ]; then
        echo "⏰ Last Used: $LAST_USED"
    fi
    echo ""
fi

# Show today's usage
TODAY=$(date "+%Y-%m-%d")
LOG_FILE="$TRACK_DIR/subagent-usage-$TODAY.jsonl"

if [ -f "$LOG_FILE" ]; then
    echo "📅 Today's Usage:"
    echo "----------------"

    # Count usage by subagent type
    echo "$LOG_FILE" | jq -r '.subagent_type' | sort | uniq -c | sort -nr | while read count agent; do
        echo "  $count × $agent"
    done

    echo ""
    echo "📋 Recent Tasks:"
    echo "--------------"

    # Show last 5 tasks
    tail -5 "$LOG_FILE" | while read line; do
        timestamp=$(echo "$line" | jq -r '.timestamp')
        agent=$(echo "$line" | jq -r '.subagent_type')
        desc=$(echo "$line" | jq -r '.description')
        echo "  $timestamp - $agent: $desc"
    done
else
    echo "No subagent usage recorded today."
fi

echo ""
echo "📊 Statistics:"
echo "-------------"

# Show total subagents available
TOTAL_AGENTS=$(find ~/.claude/agents -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "Total available agents: $TOTAL_AGENTS"

# Show usage over last 7 days
echo "Usage over last 7 days:"
find "$TRACK_DIR" -name "subagent-usage-*.jsonl" -mtime -7 | while read file; do
    date=$(basename "$file" .jsonl | sed 's/subagent-usage-//')
    count=$(wc -l < "$file")
    echo "  $date: $count uses"
done