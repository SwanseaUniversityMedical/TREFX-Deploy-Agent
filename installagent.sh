#!/bin/bash

# Tell user what this is
echo ""
echo "-----------------------------------------------------"
echo "|              TREFX Agent Installer                |"
echo "-----------------------------------------------------"
echo ""

# Define the subdirectory, file path, and repository URL
SUBDIR="./trefx-agent"
FILE_PATH="$SUBDIR/trefx-agent-id"
REPO_URL="https://github.com/SwanseaUniversityMedical/DARE-TREFX-Environment1.git"
REPO_PATH="$SUBDIR/agent"

# Create the subdirectory if it does not exist
if [ ! -d "$SUBDIR" ]; then
    mkdir -p "$SUBDIR"
    echo "Subdirectory $SUBDIR created."
else
    echo "Subdirectory $SUBDIR already exists."
fi


# Step 1: Create a local file if an environment variable (AGENT_ID) is set and write the value to the file
if [ ! -z "$AGENT_ID" ]; then
    echo "$AGENT_ID" > $FILE_PATH
    echo "Environment variable AGENT_ID is set. Value written to $FILE_PATH."
else
    # Step 2: If AGENT_ID is not set and the file already exists, read the value from the file and set the variable
    if [ -f "$FILE_PATH" ]; then
        AGENT_ID=$(cat $FILE_PATH)
        export AGENT_ID
        echo "Environment variable AGENT_ID is not set. Value read from $FILE_PATH and set to AGENT_ID."
    fi
fi

# Step 3: Test if AGENT_ID is set, if not display an error and stop
if [ -z "$AGENT_ID" ]; then
    echo "Error: Environment variable AGENT_ID is not set and $FILE_PATH does not exist."
    exit 1
else
    echo "Environment variable AGENT_ID is set to '$AGENT_ID'."
fi


# Step 4: Clone Git
# Clone the repository if it does not exist, otherwise pull the latest changes
echo "Plan to clone $REPO_URL"
git config pull.rebase false
if [ ! -d "$REPO_PATH/.git" ]; then
    git clone $REPO_URL $REPO_PATH
    echo "Repository cloned into $SUBDIR."
else
    (cd $REPO_PATH && git pull)
    echo "Repository in $SUBDIR updated."
fi