---
author: tutysara
date: 2016-09-27T03:35:35+05:30
description: Automating hugo blog using travis-ci
keywords:
- hugo
- blog
- automation
- travis-ci
- github 
tags:
- self-notes
- hugo
title: Automating hugo blog deployment to github pages using travis-ci
topics:
- topic 1
type: post
---
Here are the steps I took to build and deploy my blog automatically using hugo and travis-ci to github pages

I assume a hugo blog is already created and exist

- Create `.travis.yml` file in the project directory with the following contents
    
    ```yaml
        language: go
        sudo: required
        git:
            submodules: true
        install:
        - go get -v github.com/spf13/hugo
        script: bash ./deploy.sh
        notifications:
            email:
                on_failure: always
    ```
- Generate and encrypt github token
  - create a access token in github as [given here](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) , this is for pushing the changes to the master branch of the user site
  - install travis gem

        ```sh
            gem install travis
        ```
  - enrypt github token and incude in .travis.yml
  
        ```sh
        travis encrypt GH_TOKEN=<token generated above> --add
        ```
  
     this will also take care of including the token in .travis.yml under `secure` section
- Use this deploy script, modify and save this in a file called deploy.sh in the root dir of the project

    ```sh
        #!/bin/bash
        echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
        # setup constants
        REPO="<username>.github.io"
        GH_REPO="github.com/<username>/${REPO}.git"
        MSG=$(git log -1 --oneline)
        git config --global user.email "<example@gmail.com>"
        git config --global user.name "<name>"

        # Build the project.
        hugo -t <theme_name> # if using a theme, replace by 'hugo -t <yourtheme>'

        git clone "https://$GH_REPO"
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
    ```
- push both `.travis.yml` and `deploy.sh` to github

Now whenever a new blog is written and comitted to github, travis-ci is notified of the change.
It  builds the site automatically and pushes it to the master branch of the user site and we get the new contents in our site ;).
