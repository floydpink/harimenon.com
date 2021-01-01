#!/bin/bash

if [ -d "./.deploy_git" ]; then
  echo "Removing .deploy_git folder..."
  rm -rf ./.deploy_git
  echo "Folder removed."
fi

# Initialize target with currently deployed files
git clone --depth 1 --branch=gh-pages --single-branch https://github.com/floydpink/harimenon.com.git .deploy_git

cd .deploy_git

# Remove all files before they get copied from ../public/
# so git can track files that were removed in the last commit
find . -path ./.git -prune -o -exec rm -rf {} \; 2> /dev/null

cd ../

if [ ! -d "./public" ]; then
  echo "Generating site from within deploy.sh..."
  hexo generate
  echo "Done generating site."
fi

# Run deployment
hexo deploy -m "Site updated at $(date +'%Y-%m-%d_%H-%M-%S') [ci skip]"