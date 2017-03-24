+++
title = "Django development on OSX using emacs"
date = "2013-10-30T13:16:00"
tags = ["self-notes", "python", "django"]
+++

I started following the Django tutorials by [arun](http://arunrocks.com/building-a-hacker-news-clone-in-django-part-1/). I wanted to know about the related classes and quickly look into docs for the things that I code, I wanted an environment that is nice to newbies, helping with code completion and easy documentation lookup. I searched and found a huge list of [options](http://www.quora.com/Which-IDEs-are-best-suited-for-Django-development). Since I was begining with Django I wanted an environment that is much easier to setup, my first choice was [pycharm](http://www.jetbrains.com/pycharm/), but unfortunately the community edition of pycharm doesn't support Django [- see this](http://www.jetbrains.com/pycharm/features/editions_comparison_matrix.html).

I decided to come back to my good old friend emacs and configure it for Django development. Again a search gave a huge list of resources on how to set it up, I found this [gits](https://gist.github.com/panuta/1852087) more upto date and had what I was looking for, followed the steps there to install python, pip, Virtualenv and django with a simple correction, virtualenvwrapper.sh is located in ```/usr/local/bin/``` instead of ```/usr/local/share/python/```

Important thing is to add these line to .bash_profile
```bash
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/python/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME
```
I also didn't installed postgres as given in the gist, Instead I prefer [postgresapp](http://postgresapp.com/)

###Setup for autocompletion
#### Python side setup

Swtich to the virtual environment
```python
workon <virtualenv>
```
##### For automatic code completion install jedi
```bash
pip install jedi
```
##### For jedi to communicate with emacs
```bash
pip install epc
```
#### Emacs side setup

#####Install virtualenvironmentwrapper.el and jedi.el from MELPA.

Add this config to ```~/.emacs.d/init.el```
```elisp
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "Users/tutysara/.virtualenvs")
```

```M-x venv-workon``` to activate the virtualenv containing Django and the other libraries to start developing. Detailed instructions on using virtualenvwrapper.el can be found on its [github page](https://github.com/porterjamesj/virtualenvwrapper.el) and jedi.el also has its own set of well written [docs](http://tkf.github.io/emacs-jedi/)

To test this setup open eshell and type ```which python``` it should show a path which is inside the virtualenvs dir (```$HOME/.virtualenvs```) for proper interpreter configuration
and open a python file and type
```python
    from django.db import models
    models.Te # it should autocomple on typing dot
```
to test autocompletion for Django.

We now have a emacs setup that can be used for Django development.
There are other modes for working with templates which I will update when I install and use them.

Leave your comments on your favourite emacs setup for Django or even if you use something other than emacs too.
