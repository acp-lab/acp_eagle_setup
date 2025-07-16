#!/bin/bash
# Create a new session named "default" in detached mode
tmux new-session -d -s default

# Split the window vertically: top (70% height), bottom (30% height)
tmux split-window -v -p 5

# Split the top pane (pane 0) horizontally: left 70%, right 30%
tmux select-pane -t default:0.0
tmux split-window -h -p 3  # This makes the *new right pane* 30%, left auto becomes 70%

# Work on the bottom pane (which is now pane 2 after splitting top)
tmux select-pane -t default:0.2

# Split the bottom pane horizontally: right pane 33%
tmux split-window -h -p 33

# Select the left bottom pane to split it further
tmux select-pane -L

# Split the left bottom pane into two equal horizontal panes
tmux split-window -h -p 50

# Optional: Return to the top-left pane before sending keys
tmux select-pane -t default:0.0

# Send commands to all panes
for pane in $(tmux list-panes -t default:0 -F '#{pane_index}'); do
  tmux send-keys -t default:0.$pane "source /ext3/env_setup.sh" C-m
  tmux send-keys -t default:0.$pane "r2" C-m
  tmux send-keys -t default:0.$pane "cd /ext3/ws_acp/" C-m
  tmux send-keys -t default:0.$pane "source install/setup.bash" C-m
  tmux send-keys -t default:0.$pane "clear" C-m
done

# Attach to the session
tmux attach-session -t default