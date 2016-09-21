+++
title = "Good Font for Spacemacs"
date = "2016-09-03T14:25:00"
tags = ["self notes", "emacs"]
+++


Spacemacs recommends using source code pro as the default font, infact this is the font set in `.spacemacs` file. If the font is not availale it is substituted for some other alternative.
To find the font in use do `C-u C-x =` on my mac it was using Menlo font. DejavuSansMono looks better than Source code Pro on ubuntu and I switched to it in my ubuntu system.
A list of top programming fonts can be found at [Top programming fonts](https://github.com/hbin/top-programming-fonts "Top programming fonts")

Installation on a ubuntu system is easy, copy all the `<fontnames>.ttf` to `~/.fonts` folder and then update cache using `fc-cahce -f`.
To get the list of installed fonts use `fc-list`
