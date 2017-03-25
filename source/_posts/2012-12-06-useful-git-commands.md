---
layout: post
title: "Useful git commands"
date: 2012-12-06T06:58:00-08:00
comments: true
categories:
 - technical
tags:
published: true
---

* Compare branches after squash merge or rebase
``` bash
git log --graph --left-right --cherry-pick --oneline master...experiment
```
* Get git log graphically with all tags/branches:
``` bash
git log --all --decorate --oneline  --graph
```
* Create or delete remote branches on push:
``` bash
# create new remote branch on push
git push origin mybranch

# delete existing remote branch on push
git push origin :mybranch
```