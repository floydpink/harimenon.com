---
layout: post
title: "Useful git commands"
date: 2012-12-06T06:58:00-08:00
comments: true
categories:
 - technical
---

* Compare branches after squash merge or rebase
``` bash compare.sh
git log --graph --left-right --cherry-pick --oneline master...experiment
```
* Get git log graphically with all tags/branches:
``` bash log.sh
git log --all --decorate --oneline  --graph
```
* Create or delete remote branches on push:
``` bash remote_branch.sh
# create new remote branch on push
git push origin mybranch

# delete existing remote branch on push
git push origin :mybranch
```
