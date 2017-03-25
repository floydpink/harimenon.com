---
layout: post
title: "Compressing JSON - lzwCompress.js"
date: 2012-12-06T19:36:00-08:00
comments: true
categories:
- technical
tags:
- indexedDb
- lzwCompress.js
- JSON Key Optimization
- JSON Compression
- compressing JSON
- webSql database
- JavaScript
- oss
published: true
---

The application that I am working on now is a nice little ASP.NET MVC4 web app, whose target audience will access it on some of the popular tablets of the day - iPad, Android and Windows 8 Surface etc.!

The USP of the otherwise regular data entry app is that it has an offline mode, so that the data collection can happen even when there is no connectivity. Even with ubiquity of the data networks, this proved to be the critical aspect of the app for the client. And among the things being cached for offline mode, there is some really hefty business look-up/metadata, that has to be there for the app to function. The fact that the app would be targeting multiple devices, and because the HTML5 recommended [IndexedDB API](http://www.w3.org/TR/IndexedDB/) is still not implemented by some of the major players (Opera or Safari or any iOS6 browser), we had to fall back to the better/older/more-robust and now-deprecated [Web SQL database](http://www.w3.org/TR/webdatabase/) as well.

<!-- more -->

The app would be online, when certain business entities would get enabled for offline mode, and this is when it takes down the metadata in JSON format, to the device-supported offline database. And because this data was pretty big (approximately 15 meg per entity), this offline-enabling itself was consuming quite a bit of space. And that was just the set up with the static look up data. The main point of the app, once again, is that it helps adding transactions/entities to the offline-enabled entity, using this look-up data. These transactions again have to go to the same offline databases as JSON, and there could be a couple of hundred of these, on a single device, with almost all of them having one or two (BASE64 encoded JPEG) photos as well.

Now, at around a few hundred megs of offline data, the browsers start getting less responsive and might even start crashing when visiting pages from that domain (this bit is not confirmed across all the devices/browsers). So the gist is: we had to look into somehow optimizing the data getting stored into the device.

First thing I looked into was optimizing the redundancy innate to the JSON structure - that of the repeating keys. There were quite a [few](https://github.com/WebReflection/JSONH) such [optimizations](http://www.cliws.com/e/06pogA9VwXylo_GknPEeFA/) on the web and [this Stack Overflow question](http://stackoverflow.com/questions/4433402/replace-keys-json-in-javascript) is what finally I took. That alone shaved off around 20% in average, which was nice but not nearly enough.

Then I started exploring compression algorithms like gzip or lzw or some other such for compressing the JSON strings. And stumbled on to [this (SO again!)](http://stackoverflow.com/questions/2252465/javascript-client-data-compression). I started off with the [JS implementation](http://rosettacode.org/wiki/LZW_compression#JavaScript) mentioned in the answer there and enhanced a little bit it to make it do the JSON-key-redundancy optimization as well.

[lzwCompress.js](http://floydpink.github.com/lzwCompress.js/) was the result!

The simple usage as given in the github readme page is: {% gist 4230480 %}

All (well, almost all - there are [a few unit tests](http://htmlpreview.github.com/?https://github.com/floydpink/lzwCompress.js/blob/master/test/test.html) that pass) valid JavaScript objects, when applied through the pack and unpack cycled would retain its structure and form. And most of them would have an average compression of 45-80% after the pack, which is what could be used to store to offline databases, maybe sending up to server etc.

Feel free to use it for anything where you would need compression of your JSON (or any JavaScript) data structures.
