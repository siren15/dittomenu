#!/bin/bash
# Simple command launcher
# Usage: launch-desktop.sh "command to execute"

CMD_TO_EXECUTE="$1"

if [ -z "$CMD_TO_EXECUTE" ]; then
    exit 1
fi

# If it's a .desktop file, use gtk-launch or kioclient to handle it properly
if [[ "$CMD_TO_EXECUTE" == *.desktop ]]; then
    DESK_FILE=$(basename "$CMD_TO_EXECUTE")
    CMD_TO_EXECUTE="gtk-launch '$DESK_FILE' || kioclient6 exec '$CMD_TO_EXECUTE' || kioclient5 exec '$CMD_TO_EXECUTE'"
fi

# Launch in background, completely detached from parent
nohup sh -c "$CMD_TO_EXECUTE" >/dev/null 2>&1 &
exit 0
