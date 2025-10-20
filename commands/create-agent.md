---
name: create-agent
description: Create a new AI agent with template structure
---

# Create New AI Agent

This command helps you create a new AI agent with the proper structure and boilerplate code.

## Usage
```
/create-agent <agent-name> --type=<agent-type> --capabilities=<capabilities>
```

## Agent Types
- **task-agent** - Single-purpose task execution
- **workflow-agent** - Multi-step workflow orchestration
- **specialist-agent** - Domain-specific expertise
- **coordination-agent** - Multi-agent coordination

## Capabilities
- **code-analysis** - Analyze and understand code
- **code-generation** - Generate code solutions
- **testing** - Create and run tests
- **documentation** - Generate documentation
- **debugging** - Debug and fix issues
- **optimization** - Optimize performance

## Example
```
/create-agent code-reviewer --type=specialist-agent --capabilities=code-analysis,documentation,testing
```

This will create:
- Agent configuration file
- Core agent implementation
- Test suite
- Documentation template
- Integration examples

The agent will be automatically added to your project's `.claude/agents/` directory and available for immediate use.