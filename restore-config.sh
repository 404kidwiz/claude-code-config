#!/bin/bash

# Claude Code Configuration Restore Script
# Restores configuration from backup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Restoring Claude Code configuration..."
echo "📁 Source: $SCRIPT_DIR"

# Create directories if they don't exist
mkdir -p ~/.claude/{agents,commands,output-styles,templates,automation}

# Restore configuration files
if [ -f "$SCRIPT_DIR/config/settings.local.json" ]; then
    echo "📋 Restoring settings.local.json..."
    cp "$SCRIPT_DIR/config/settings.local.json" ~/.claude/
fi

if [ -f "$SCRIPT_DIR/config/.mcp.json" ]; then
    echo "🔧 Restoring .mcp.json..."
    cp "$SCRIPT_DIR/config/.mcp.json" ~/.claude/
fi

# Restore agents
if [ -d "$SCRIPT_DIR/agents" ]; then
    echo "🤖 Restoring agents..."
    cp "$SCRIPT_DIR/agents"/*.md ~/.claude/agents/ 2>/dev/null
fi

# Restore commands
if [ -d "$SCRIPT_DIR/commands" ]; then
    echo "⚡ Restoring commands..."
    cp "$SCRIPT_DIR/commands"/*.md ~/.claude/commands/ 2>/dev/null
fi

# Restore status lines
if [ -d "$SCRIPT_DIR/status-lines" ]; then
    echo "📊 Restoring status line scripts..."
    cp "$SCRIPT_DIR/status-lines"/*.sh ~/.claude/ 2>/dev/null
    chmod +x ~/.claude/status-line*.sh 2>/dev/null
    chmod +x ~/.claude/show-subagent-history.sh 2>/dev/null
fi

# Restore automation scripts
if [ -d "$SCRIPT_DIR/automation" ]; then
    echo "🔧 Restoring automation scripts..."
    cp -r "$SCRIPT_DIR/automation"/* ~/.claude/automation/ 2>/dev/null
    chmod +x ~/.claude/automation/*.sh 2>/dev/null
fi

# Restore output styles
if [ -d "$SCRIPT_DIR/output-styles" ]; then
    echo "🎨 Restoring output styles..."
    cp -r "$SCRIPT_DIR/output-styles"/* ~/.claude/output-styles/ 2>/dev/null
fi

# Restore templates
if [ -d "$SCRIPT_DIR/templates" ]; then
    echo "📋 Restoring templates..."
    cp -r "$SCRIPT_DIR/templates"/* ~/.claude/templates/ 2>/dev/null
fi

echo "✅ Configuration restored successfully!"
echo "🔄 Please restart Claude Code to apply changes."
