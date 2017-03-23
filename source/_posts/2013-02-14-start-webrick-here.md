---
layout: post
title: "Start WEBrick Web Server Here"
date: 2013-02-14 21:40
comments: true
categories: [technical, webrick, webserver, bash]
published: true

---

I have started dabbling with [Ember.js](http://emberjs.com/) and it sure looks awesome!

This necessitated a quick and easy way to start serving the current directory through some webserver. And because of the recent adventures with Octopress, I happened to be aware of the presence of WEBrick as a nifty, light-weight server.

This led me to google `"start a webrick server at current directory windows"` and the first link was to [this question](http://stackoverflow.com/questions/3108395/serve-current-directory-from-command-line) on Stack Overflow.

<!-- more -->Thanks to [the highly voted (albeit not the accepted) answer](http://stackoverflow.com/a/7105609/218882) there, I added this snippet to my `.bashrc`:
``` bash
function serve {
  port="${1:-3000}"
  ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"
}
```

And, Voila! I now have the current directory served via WEBrick, just by using the command of `serve <desired-port-number>`.

That was good!