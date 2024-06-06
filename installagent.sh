#!/bin/bash

# Tell user what this is
echo ""
echo "-----------------------------------------------------"
echo "|              TREFX Agent Installer                |"
echo "-----------------------------------------------------"
echo ""

# Define the subdirectory, file path, and repository URL
SUBDIR="./trefx-agent"
SECRET_PATH="$SUBDIR/secrets"
FILE_PATH="$SUBDIR/trefx-agent-id"
REPO_URL="https://github.com/SwanseaUniversityMedical/TREFX-Deploy-Agent.git"
REPO_PATH="$SUBDIR/agent"

# Create the subdirectory if it does not exist
if [ ! -d "$SUBDIR" ]; then
    mkdir -p "$SUBDIR"
    echo "Subdirectory $SUBDIR created."
else
    echo "Subdirectory $SUBDIR already exists."
fi


#AGENT_ID == URL TO JSON for override
#AGENT_TYPE == string for foleder of what tpye of projets
# Step 1: Create a local file if an environment variable (AGENT_ID) is set and write the value to the file
echo "STEP 1 : Get Agent ID"
if [ ! -z "$AGENT_ID" ]; then
    echo "$AGENT_ID" > $FILE_PATH
    echo "Environment variable AGENT_ID is set. Value written to $FILE_PATH."
else
    echo "STEP 1b : Get Agent ID from file"
    # Step 1b: If AGENT_ID is not set and the file already exists, read the value from the file and set the variable
    if [ -f "$FILE_PATH" ]; then
        AGENT_ID=$(cat $FILE_PATH)
        export AGENT_ID
        echo "Environment variable AGENT_ID is not set. Value read from $FILE_PATH and set to AGENT_ID."
    fi
fi

# Step 2: Test if AGENT_ID is set, if not display an error and stop
echo "STEP 2 : Check we have an Agent ID"

if [ -z "$AGENT_ID" ]; then
    echo "Error: Environment variable AGENT_ID is not set and $FILE_PATH does not exist."
    exit 1
else
    echo "Environment variable AGENT_ID is set to '$AGENT_ID'."
fi

if [ -z "$AGENT_TYPE" ]; then
    echo "Error: Environment variable AGENT_TYPE not set."
    exit 1
else
    echo "Environment variable AGENT_TYPE is set to '$AGENT_TYPE'."
fi



# Step 3: Clone Git
echo "STEP 3 : Clone the repository if it does not exist, otherwise pull the latest changes"

echo "Plan to clone $REPO_URL"
if [ ! -d "$REPO_PATH/.git" ]; then
    git clone $REPO_URL $REPO_PATH
    echo "Repository cloned into $SUBDIR."
	(cd $REPO_PATH && git checkout John/addSub )
else
    (cd $REPO_PATH && git config pull.rebase false && git pull)
    echo "Repository in $SUBDIR updated."
	(cd $REPO_PATH && git checkout John/addSub )
fi

# Step 4: Set .env file correctly
echo "STEP 4 : Set configuration based on Agent ID"

if [ ! -d "$SECRET_PATH" ]; then
    mkdir -p "$SECRET_PATH"
    echo "Subdirectory $SECRET_PATH created."
else
    echo "Subdirectory $SECRET_PATH already exists."
fi

echo "Downloading and running configuration tool"

docker pull harbor.ukserp.ac.uk:443/dare-trefx/deployconfig:1.0.0

docker run --name configure --rm \
    -v $(pwd)/$REPO_PATH/deployments/$AGENT_TYPE:/env \
    -v $(pwd)/$SECRET_PATH:/secret  \
    -e passwordDir=/secret \
    -e sourceEnv=/env/.env.template \
    -e targetEnv=/env/.env \
    -e http_proxy=$http_proxy \
	-e url=$AGENT_ID \
    harbor.ukserp.ac.uk:443/dare-trefx/deployconfig:1.0.0

# Step 5 start docker compose
#echo "STEP 5 : Start Docker Compose"

#(cd $REPO_PATH/deployments/$AGENT_TYPE && docker compose down)
#(cd $REPO_PATH/deployments/$AGENT_TYPE && docker compose up -d)

#docker ps -a

echo ""
echo "-----------------------------------------------------"
echo "|              TREFX Agent Installer    FINISHED     |"
echo "-----------------------------------------------------"
echo ""

