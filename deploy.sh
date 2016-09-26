#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git config --global user.email "tutysara-travis-ci@gmail.com"
git config --global user.name "tutysara"

# Build the project.
hugo -t hugo-bootstrap # if using a theme, replace by `hugo -t <yourtheme>`

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
git commit -a -m "latest via travis"
git push "https://${GH_TOKEN}@${GH_REPO}" master > /dev/null 2>&1
