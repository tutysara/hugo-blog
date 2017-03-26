---
author: tutysara
date: 2017-03-26T19:17:21+05:30
keywords:
- hugo
- breaking change
tags:
- hugo
title: Fix isset error in Hugo 2 version
topics:
- topic 1
type: post
---

I have setup automatic compiling and deploying of my blog using Travis.CI

Recently I encountered a strange issue, the blog compiles and runs fine in my system but the site doesn't come up after a Travis build.

On investigation found this in the logs from Travis CI.

    Deploying updates to GitHub...
    Started building sites ...
    ERROR 2017/03/25 02:31:30 .Page's Use RSSlink is deprecated and will be removed in Hugo 0.21. RSSLink.
    ERROR 2017/03/25 02:31:30 partials/homepage.html template: partials/homepage.html:3:10: executing "partials/homepage.html" at <isset .Site.Params.s...>: error calling isset: unsupported type "invalid"

My local hugo from homebrew was v0.19 and the installation in Travis uses the latest hugo build

Turns out that there is a breaking change in hugo which affects the syntax of isset.
https://discuss.gohugo.io/t/v0-20-error-error-calling-isset-unsupported-type-invalid/5668

If we have a line of code where isset is use like this

    {{ if isset .Site.Params.showBlogHeader true }}

It should be changed to

    {{ if isset .Site.Params "showBlogHeader" }}
  
After making the change, to test, use the latest hugo


    brew uninstall hugo
    brew install hugo --HEAD

With these changes and testing the issue is fixed.
