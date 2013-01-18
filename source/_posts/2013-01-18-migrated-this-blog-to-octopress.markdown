---
layout: post
title: "Migrated this blog to Octopress"
date: 2013-01-18 01:55
comments: true
categories: [blog, blog migration, octopress, blogger, blogger to octopress, sinatra] 
---

This blog had been on blogger since its inception back in 2009, though it really has only a very few posts in those almost-four years. The newly found love for the [Octopress](http://octopress.org/) blogging platform, thanks to the experience setting up the [flickrdownloadr blog](http://flickrdownloadr.com/blogs) recently, I decided to bite the bullet and move my technical blog over.

This [really nice post](http://approache.com/blog/migrating-from-blogger-to-octopress/) by [Dmytrii Nagirniak](http://github.com/dnagir) made the whole migration process really a breeze, thanks to the nifty [Blogger-Octopress migration script](https://gist.github.com/1765496) and the simple [Sinatra](http://www.sinatrarb.com/) [redirection app](https://github.com/dnagir/approache-redirects/blob/master/app.rb) he has provided there. Even though I ended up not using the sinatra app, because for me: a) the domain name is not changing during this migration and b) the new permalink slug in fact has additional element - which is the `day` from the published date (whereas the blogger permalink format was just `year` and `month`). So unless I hard-code all the post URLs to be redirected (which in reality I could, considering I have just 13 posts that are being moved), the redirection app I thought, is not worth it.

I did manualy add all the old permalinks with static meta-tag and JavaScript based redirection though. So if you watch the headers in fiddler or something while clicking this old blogger URL - [http://technology.harimenon.com/2012/12/lzwCompress.js.html](http://technology.harimenon.com/2012/12/lzwCompress.js.html), you would see a page come down with 200, that does either of a `<meta http-equiv="refresh" content="0;url=..."/>` refresh or the `location.replace('...')` from the JavaScript within, to the new URL on Octopress - [http://technology.harimenon.com/blog/2012/12/06/lzwCompress.js/](http://tech.harimenon.com/blog/2012/12/06/lzwCompress.js/). 

But all the old label/category/archive links etc. (like this one - [http://technology.harimenon.com/search/label/ClickOnce Deployment](http://technology.harimenon.com/search/label/ClickOnce Deployment) would  remain broken but I have decided that's how it's going to be.

Hopefully, the new blogging platform would be _the_ impetus that I've been waiting for to start churning up a lot of posts!