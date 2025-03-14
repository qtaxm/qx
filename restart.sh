#!/bin/bash

# Step 1: List all screen sessions
echo "Listing all screen sessions..."
screen -ls

# Step 2: Attach to the 'hyper' screen session
echo "Attaching to screen session 'hyper'..."
screen -r hyper || { echo "Screen session 'hyper' not found!"; exit 1; }

# Step 3: Stop the node
echo "Stopping the node..."
aios-cli kill

# Step 4: Start the node again and redirect the output to a log file
echo "Starting the node..."
aios-cli start --connect >> /root/aios-cli.log 2>&1

echo "Node has been restarted successfully!"
