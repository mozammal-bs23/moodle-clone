#!/bin/bash

# Runs after each task completes. Tracks completion and triggers analyze when all done.

LOCK_FILE="./.claude/.task-monitor-lock"
TASK_LIST_CACHE="./.claude/.tasks-cache.json"
mkdir -p "$(dirname "$LOCK_FILE")"

{
  flock -n 200 || exit 0  # Skip if already running

  # Count total vs completed tasks (simple approach: sample every completion)
  TOTAL=$(ls -1 ./.claude/tasks/ 2>/dev/null | wc -l || echo "0")
  COMPLETED=$(grep -c '"status":"completed"' "$TASK_LIST_CACHE" 2>/dev/null || echo "0")

  if [ "$TOTAL" -gt 0 ] && [ "$TOTAL" -eq "$COMPLETED" ]; then
    # All tasks complete - run analyze workflow
    echo "All tasks complete. Running flutter analyze..." >&2

    # Run analyze
    ANALYZE_OUTPUT=$(fvm flutter analyze 2>&1 || true)
    ISSUES_FILE="./.claude/ANALYZE_ISSUE.md"

    # Generate markdown report
    {
      echo "# Flutter Analyze Issues"
      echo ""
      echo "**Generated:** $(date)"
      echo "**Total Issues:** $(echo "$ANALYZE_OUTPUT" | grep -cE "^\s*(error|warning|info):" || echo "0")"
      echo ""
      echo "## Issues"
      echo ""
      echo "\`\`\`"
      echo "$ANALYZE_OUTPUT" | tail -50  # Last 50 lines
      echo "\`\`\`"
      echo ""
      echo "## Status: Ready for fixing"
      echo ""
    } > "$ISSUES_FILE"

    # Notify via hook
    echo "{\"systemMessage\": \"Flutter analyze done. $ISSUES_FILE created. Ready to spawn fixers.\"}"
  fi

} 200>"$LOCK_FILE"
