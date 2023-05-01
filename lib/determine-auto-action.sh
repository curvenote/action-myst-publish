#!/usr/bin/env bash

# adapted from: https://github.com/rossjrw/pr-preview-action

case $GITHUB_EVENT_NAME in
  "pull_request" | "pull_request_target")
    echo "event_name is $GITHUB_EVENT_NAME; proceeding"
    ;;
  "push")
    echo "event_name is $GITHUB_EVENT_NAME; deploying"
    echo "action=deploy" >> "$GITHUB_ENV"
    exit 0
    ;;
  *)
    echo "unknown event $GITHUB_EVENT_NAME; no action to take"
    echo "action=none" >> "$GITHUB_ENV"
    exit 0
    ;;
esac

event_type=$(jq -r ".action" "$GITHUB_EVENT_PATH")
echo "event_type is $event_type"

case $event_type in
  "opened" | "reopened" | "synchronize")
    echo "action=deploy" >> "$GITHUB_ENV"
    ;;
  "closed")
    echo "action=remove" >> "$GITHUB_ENV"
    ;;
  *)
    echo "unknown event type $event_type; no action to take"
    echo "action=none" >> "$GITHUB_ENV"
    ;;
esac
