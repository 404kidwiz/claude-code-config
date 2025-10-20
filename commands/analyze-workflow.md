---
name: analyze-workflow
description: Analyze and optimize agent workflows
---

# Analyze Agent Workflow

This command analyzes your current agent workflows, identifies bottlenecks, and suggests optimizations.

## Features
- **Performance Analysis** - Identify slow operations
- **Dependency Mapping** - Map agent dependencies
- **Optimization Suggestions** - Recommend improvements
- **Resource Usage** - Monitor resource consumption

## Usage
```
/analyze-workflow --agent=<agent-name> --depth=<analysis-depth>
```

## Analysis Levels
- **basic** - High-level overview
- **detailed** - Comprehensive analysis
- **comprehensive** - Deep dive with recommendations

## Output Includes
- Workflow visualization
- Performance metrics
- Bottleneck identification
- Optimization roadmap
- Resource utilization report

## Example
```
/analyze-workflow --agent=code-reviewer --depth=detailed
```

This will provide a comprehensive analysis of the code-reviewer agent's workflow, including:
- Average execution time
- Common failure points
- Resource usage patterns
- Suggested optimizations