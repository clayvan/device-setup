#!/bin/bash

# Create VS Code directories if they don't exist
mkdir -p ~/Library/Application\ Support/Code/User/

# Copy settings
cp settings.json ~/Library/Application\ Support/Code/User/settings.json

# Install extensions
while read extension; do
  code --install-extension "$extension"
done < extensions.txt

echo "VS Code settings and extensions installed successfully!"