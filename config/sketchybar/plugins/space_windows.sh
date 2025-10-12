#!/bin/bash

# Function to update workspace display
update_workspace() {
  local workspace_id="$1"
  
  # Get apps in workspace
  apps=$(aerospace list-windows --workspace "$workspace_id" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  
  if [ "${apps}" != "" ]; then
    sketchybar --set space.$workspace_id drawing=on
    icon_strip=" "
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    done <<< "${apps}"
    sketchybar --set space.$workspace_id label="$icon_strip"
  else
    sketchybar --set space.$workspace_id drawing=off label=""
  fi
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # Update both previous and focused workspaces
  [ -n "$PREV_WORKSPACE" ] && update_workspace "$PREV_WORKSPACE"
  [ -n "$FOCUSED_WORKSPACE" ] && update_workspace "$FOCUSED_WORKSPACE"
  
elif [ "$SENDER" = "front_app_switched" ]; then
  # When app switches, update current workspace
  CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)
  [ -n "$CURRENT_WORKSPACE" ] && update_workspace "$CURRENT_WORKSPACE"
fi
