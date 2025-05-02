#!/bin/bash

SERVICE="docker"
if pgrep -x "$SERVICE" >/dev/null
then
    echo "$SERVICE is running"
else
    echo "$SERVICE is NOT running! Sending alert..."
    # Replace with email or webhook command here
fi
