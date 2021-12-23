---
layout: post
title: "Update Global npm Packages"
date: 2021-12-23T12:03:00-05:00
comments: true
categories:
 - technical
tags:
 - bash
 - zsh
 - node.js
 - npm
 - dependencies
 - jq
 - one-liner
published: true
---

I rely on [the amazing `nvm` library](https://github.com/nvm-sh/nvm) to maintain multiple, side-by-side major versions of Node.js to help me work with many different applications. I also use quite a few global CLI applications written in Node.js. These are typically installed with this command:


``` bash
npm install --global <package-name>
```

To update these globally installed packages, I used to rely on this manual workflow:

1. List the globally installed packages using `npm ls --global --depth=0`
2. Copy paste the names of all the packages from the output of the above command to install them again - like `npm install --global <package-1>  <package-2> ...  <package-n>`

Since I found myself doing this every few days, and that too, for every side-by-side version of Node.js I have on my machine, I decided to spend some time today to convert this into a one-liner command (which I can then add as an alias into my `.zshrc` file).

Since I also have [the awesome `jq` utility](https://stedolan.github.io/jq/) installed on my machine, this is what I have come up with:

``` bash
npm ls --global --json --depth=0 | jq --raw-output '.dependencies | keys | join(" ")' | xargs npm install --global
```
