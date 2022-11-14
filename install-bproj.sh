#!/usr/bin/env bash
#set -ex


read -r -p "Are you sure you want to install/upgrade .bproj in $PWD? [y/N]" response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    GIT=`which git`
    if [[ "$GIT" == '' ]]; then
        echo "Missing \`git\` program. Please install \`git\` first."
        echo "This command may help: \`apt-get install git\`"
        exit
    fi

    git clone https://github.com/Rp70/dotbproj.git dotbproj # Clone this repo
    rm -rdf ./.bproj # Remove the exising version
    mv dotbproj/.bproj ./ # Move the .bproj to your project folder
    rm -rdf dotbproj # Clean up the cloned repo
    echo ".bproj installed. Thank you!"
else
    echo "Installation/Upgrade cancelled. Thank you!"
fi
