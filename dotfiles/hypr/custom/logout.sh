#!/bin/bash

# Define the command you want to run
# Replace 'echo "Hello, world!"' with your actual command
COMMAND_TO_RUN='hyprctl dispatch exit'

# Display the GUI prompt
zenity --question --title="Confirmation" --text="Do you want to logout?"

# Check the exit status of zenity
# 0 means 'Yes' was clicked, 1 means 'No' was clicked or the dialog was closed
if [ $? -eq 0 ]; then
  echo "You chose Yes. Executing: $COMMAND_TO_RUN"
  eval "$COMMAND_TO_RUN"
else
  echo "You chose No or closed the dialog. Command not executed."
fi
