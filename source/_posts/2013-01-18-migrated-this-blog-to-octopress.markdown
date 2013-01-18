---
layout: post
title: "Migrated this blog to Octopress"
date: 2013-01-18 01:55
comments: true
categories: [blog, blog migration, octopress, blogger, blogger to octopress, sinatra] 
---
This blog had been on blogger since its inception back in 2009, though it reallly has only a very few posts in those almost-four years. The newly found love for the [Octopress](http://octopress.org/) blogging platform, thanks to the experience from setting up the [flickrdownloadr blog](http://flickrdownloadr.com/blogs) recently, I decided to bite the bullet and move the technology blog over.

This [really nice post](http://approache.com/blog/migrating-from-blogger-to-octopress/) by [Dmytrii Nagirniak](http://github.com/dnagir) made the whole migration process really a breeze, thanks to the nifty [Blogger-Octopress migration script](https://gist.github.com/1765496) and the simple [Sinatra](http://www.sinatrarb.com/) [redirection app](https://github.com/dnagir/approache-redirects/blob/master/app.rb) he has provided there. I ended up not using the sinatra app, as for me, the domain name is not changing during this migration and also, the new slug actually has one new element - the day from the published date (which was missing on blogger permalink format). So unless I hard-code all the post URLs to be redirected (which in reality I could, considering I have just 13 posts that are being moved), the redirection app I thought, is not worth it.

I did manualy add all the old permalinks with static meta-tag and javascript based redirection though. So if you watch the headers in fiddler or something while clicking this old blogger URL - [http://technology.harimenon.com/2012/12/lzwCompress.js.html](http://technology.harimenon.com/2012/12/lzwCompress.js.html), you would see a page come down with 200, that does either of a `meta-tag` refresh or the `location.replace` from the javascript within to the new page on Octopress - [http://technology.harimenon.com/blog/2012/12/06/lzwCompress.js/](http://tech.harimenon.com/blog/2012/12/06/lzwCompress.js/). 

But all the old label/archive links etc. (like this one - [http://technology.harimenon.com/search/label/ClickOnce Deployment](http://technology.harimenon.com/search/label/ClickOnce Deployment) would  remain broken and I have decided that it is how it is going to be.

Hopefully, the new blogging platform would be the impetus that I've always been waiting for!