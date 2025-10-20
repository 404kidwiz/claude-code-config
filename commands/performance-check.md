---
name: performance-check
description: Monitor and analyze agent performance metrics
---

# Performance Check

Monitor agent performance, identify issues, and generate optimization recommendations.

## Metrics Tracked
- **Execution Time** - How long agents take to complete tasks
- **Success Rate** - Percentage of successful completions
- **Resource Usage** - CPU, memory, and API consumption
- **Error Patterns** - Common failure modes and causes

## Usage
```
/performance-check --agent=<agent-name> --period=<time-period>
```

## Time Periods
- **hour** - Last hour of activity
- **day** - Last 24 hours
- **week** - Last 7 days
- **month** - Last 30 days

## Report Includes
- Performance graphs and charts
- Trend analysis over time
- Comparison with baseline
- Actionable recommendations
- Resource optimization tips

## Example
```
/performance-check --agent=code-reviewer --period=week
```

Generates a comprehensive performance report showing:
- Average response time trends
- Success/failure patterns
- Resource usage efficiency
- Optimization opportunities
- Performance benchmarks

## Integration with Monitoring
- Integrates with session tracking
- Correlates with subagent usage
- Provides alerts for performance degradation
- Suggests workflow improvements