#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
# setup constants
REPO="tutysara.github.com"
GH_REPO="github.com/tutysara/${REPO}.git"
MSG=$(git log -1 --oneline)
git config --global user.email "tutysara-travis-ci@gmail.com"
git config --global user.name "tutysara"

# get theme
rm -rf themes/*
git clone https://github.com/halogenica/beautifulhugo.git themes/theme-beautifulhugo
git clone https://github.com/tutysara/tutysara.net.comments comments
rm -rf data
ln -s comments/data data
# Build the project.
hugo -t theme-beautifulhugo # if using a theme, replace by `hugo -t <yourtheme>`

git clone https://github.com/tutysara/tutysara.github.com.git
# clean up repo
cd  ${REPO}
rm -rf *
cd ..
# copy files to commit
cp -R public/* ${REPO}
cd ${REPO}
git remote
git add -A :/
git commit -a -m "via travis -- for $MSG"
git push "https://${GH_TOKEN}@${GH_REPO}" master > /dev/null 2>&1
