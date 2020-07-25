#!/bin/bash

# Script to start a tmux session with the perfered layout
# ---------------------------
# |                 |       |
# |                 |       |
# |                 |_______|        
# |                 |       |
# |                 |       |
# |_________________|_______|

tmux new-session -d -s Main;
tmux split-window -h -p 20;
tmux split-window -v -p 50;
tmux select-pane -L;
tmux attach-session -d -t Main;
