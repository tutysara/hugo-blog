---
author: tutysara
date: 2018-02-07
keywords:
- jupyter
- python
tags:
- sklearn
- python
title: Themes and Extensions for Jupyter notebook
topics:
- ML
type: post
---

I am taking the wonderful [fast.ai](http://course.fast.ai/) course thought by Jermey Howard and Rachel.
We use jupyter notebooks in classes and it is always nice to see how Jermey's notebook looks.

It has few tweaks like

- collapsible headings
- better tables and fonts

Learnt that he uses a themes for the visual customizations and an extensions to allow collapsing of headers from his reply in [forums](http://forums.fast.ai/t/collapsable-expandable-jupyter-cells/205/5)

The theme script can be installed from [jupyter-themes repo](https://github.com/dunovank/jupyter-themes)

and for the themes install grade3 theme.

Quick instructions

		pip install jupyterthemes
		jt -t grade3

The extensions can be installed from [jupyter_contrib_nbextensions repo] (https://github.com/ipython-contrib/jupyter_contrib_nbextensions)

Quick instructions

		pip install jupyter_contrib_nbextensions

Configure collapsible headings  extension from notebook menu

		Edit -> nbextensions config