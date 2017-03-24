---
author: tutysara
date: 2017-03-24T09:07:41+05:30
description: Spacemacs Ctrl+i fix 
draft: true
keywords:
- spacemacs
tags:
- spacemacs
- two
title: Spacemacs Ctrl i Not Working
topics:
- topic 1
type: post
---

Spacemacs uses Ctlr+o to move backward to the last edited location and Ctrl+i to move foward after going back using Ctrl+o similar to Vim.
I found that Ctrl+o works but Ctrl+i doesn't moves forward through the edit locations. I had the same issue in OSX/emacs 25.1 and in ubuntu/emacs25.1.
Searched the net and found this helpful issue page -- https://github.com/syl20bnr/spacemacs/issues/5050

They have the troubleshooting steps there

(lookup-key evil-motion-state-map [C-i]) ;; should be evil-jump-forward
(display-graphic-p) ;; should be t
dotspacemacs-distinguish-gui-tab ;; should be t
(lookup-key key-translation-map [?\C-i]) ;; should be spacemacs/translate-C-i

In my system dotspacemacs-distinguish-gui-tab is set as nil.
So, this is the issue. I set this variable in .spacemacs file and refreshed and I could use Ctrl+i to move forward through the links
