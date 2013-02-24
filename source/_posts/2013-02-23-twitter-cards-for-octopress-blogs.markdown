---
layout: post
title: "Twitter Cards for Octopress blogs"
date: 2013-02-23 19:21
comments: true
published: true
categories: [technical, twitter, blog, octopress, Twitter Cards]
---

The first time I heard about [Twitter Cards](https://dev.twitter.com/docs/cards) is from [the GitHub blog entry](https://github.com/blog/1388-github-now-supports-twitter-cards) announcing they have implemented it for all the GitHub respositories. And if you haven't heard about them, go to either of those posts and you'd get a quick overview.

Anyways, since the time I read that blog, I have been thinking of trying to implement it here on this blog as well as on the other website I've been actively maintaining lately - [flickrdownloadr.com](http://flickrdownloadr.com). Finally got around to doing it yesterday on the static pages at flickrdownloadr site (even though I am still waiting for Twitter to approve my site).

<!-- more -->Today, I took it one step further by implementing it here and on [the blog there](http://flickrdownloadr.com/blogs/), which are both built with the awesome [Octopress](http://octopress.org) platform. Turned out to be pretty straight-forward - just add the below snippet into the `source/_includes/custom/head.html` and you should be all set.

``` html twitter_cards
{% raw %}{% if site.twitter_user %}
    <meta property="twitter:card" content="summary">
    <meta property="twitter:site" content="{{ site.twitter_user }}">
    <meta property="twitter:url" content="{% if canonical %}{{ canonical }}{% else %}{{ site.url }}{% endif %}">
    <meta property="twitter:title" content="{% if page.title %}{{ page.title }}{% else %}{{ site.title }}{% endif %}">
    <meta property="twitter:description" content="{{ description | strip_html | condense_spaces | truncate:200 }}">
{% endif %}{% endraw %}
```

P.S: Also, you would need to apply (or "opt-in") for Twitter Cards [here](https://dev.twitter.com/form/participate-twitter-cards) **_and_** they will have to approve it for the cards to start showing up.