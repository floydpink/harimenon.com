#!/bin/zsh
mkdir .deploy
cd .deploy || exit
git clone --depth 1 --branch gh-pages --single-branch "$DEPLOY_REPO" . || (git init && git remote add -t gh-pages origin "$DEPLOY_REPO")
rm -rf ./*
cp -r ../public/* .
git add -A .
git commit -m "Site updated at $(date +'%Y-%m-%d_%H-%M-%S')"
git branch -m gh-pages
git push -q -u origin gh-pages
