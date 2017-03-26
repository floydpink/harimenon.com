---
layout: post
date: 2013-09-09 00:40
comments: true
categories:
 - technical
tags: [Mantis CI, iOS, Android, Travis CI, PhoneGap, mobile app, story]
published: true
title: The Story Behind Mantis CI
created_at: Mon 09 Sep 2013 00:49:00 EDT
---

### Mantis CI

<span style="color: #ff0000;">M</span>obile <span style="color: #ff0000;">A</span>pplicatio<span style="color: #ff0000;">n</span> for <span style="text-wrap: none;"><span style="color: #ff0000;">T</span>rav<span style="color: #ff0000;">is CI</span>™</span>

<a href="https://play.google.com/store/apps/details?id=com.floydpink.android.travisci" target="_blank" style="display:inline-block;overflow:hidden;background:url(https://developer.android.com/images/brand/en_generic_rgb_wo_45.png) no-repeat;width:135px;height:45px;background-position:center;"></a>
<a href="https://itunes.apple.com/us/app/travis-ci-mobile/id665742482?mt=8&amp;uo=4" target="_blank" style="display:inline-block;overflow:hidden;background:url(/images/app-store-badge.png) no-repeat;width:135px;height:45px;background-position:center;"></a>

_**tl;dr**: [Mantis CI](http://floydpink.github.io/Mantis-CI/), is a free app (available for both iOS/Android) that attempts to be a mobile-optimized client for Travis CI. Please install them and share your feedback._

<div style="text-align:center;"><a href="http://floydpink.github.io/Mantis-CI/"><img alt="Mantis CI" src="https://i.imgur.com/JYV2Nyz.png" width="300" height="300" /></a></div>

For a while now, a mobile port of the [Travis CI](https://travis-ci.org) web application that I packaged as a [PhoneGap](http://phonegap.com/) app had been available for Android [on Google Play](https://play.google.com/store/apps/details?id=com.floydpink.android.travisci).

Quite recently I managed to wrap the same HTML5 app into an iOS app as well, thanks to detailed guides at PhoneGap and a lot of good questions on StackOverflow.

It was a good experience in trying to the do similar things that worked on the Linux/Eclipse/Android on to the Mac/Xcode/iOS. 

Click on the buttons above to download the app from one of the stores. Also you could find out more about the apps and get to the open source repositories etc. from [here](http://floydpink.github.io/Mantis-CI/).

Below is a short (self-centric) story behind these apps. :-)

<!-- more -->

### Hackathon

Almost an year ago, I took part in a mobility-hackathon-weekend organized by my employer of then, along with a few co-workers. We were all seasoned .NET/Web developers but had no prior experience with any mobile app development. But since most of us were dabbling with HTML5, and hacking in some fairly advanced JavaScript bits, we were quick to decide the weapon-of-choice to be [Cordova/PhoneGap](http://phonegap.com/).

As we had been using Jenkins CI for .NET apps at work successfully, we looked around for something similar and our explorations led us to discover Travis CI. We started using it for the continuous build and deployment (commit back to the same GitHub repo - thanks secure environment variables!) of the Android `apk` file.

We also figured out how to use the git submodules to maintain one shared web-app repository that could then be built separately into an Android-PhoneGap and an iOS-PhoneGap app - using a total of three GitHub repos.

The long and short of it all is that this continuous build process enabled by Travis CI, played a very crucial role in how we finally did present our solution and eventually in us winning the first prize (a handsome $250/hacker) at that hackathon! We were all very proud and also knew a little bit of Android app development using PhoneGap.

But we all went back to doing the (kinda boring) .NET web development day jobs.

In a few weeks, I quit that job and joined the current gig where the day-job was still .NET development, although a little better as here, the web apps were targeting mobile phones and tablets. 

But it still wasn't giving me the kicks I was looking for. Also, I did not want to let the new-found PhoneGap skills to go wasted. I noticed that there are no (functional) iOS or Android apps available for Travis CI and that doing one could be a nice little side project. That, I thought, would also be a tiny contribution back in to the Travis CI community and importantly, a good way to keep learning more of mobile app development.

### Android

I started looking into the [travis desktop web client](https://github.com/travis-ci/travis-web), to try and figure out how it is built. This led me to discover [ember.js](http://emberjs.com/) and after seeing the beauty of the truly "next-generation web client" that Travis web client is, I decided to grok up ember.js and to port this official ember.js-powered desktop web client into a mobile one. 

Some good mobile-optimized views, leveraging [jQuery mobile](http://jquerymobile.com/) could do the job, I thought. It proved to be so much more harder than i had imagined and i finally ended up using jQuery mobile pre-rendered markup from within the ember/handlebars views.

I also decided to go with JavaScript rather than the CoffeeScript that the travis-web is written in and also to learn and implement the AMD pattern with [require.js](http://requirejs.org/) along with [Grunt.js](http://gruntjs.com/) to help get a solid build process going.

Soon the app started getting continuously built (thanks to Travis CI!) both as [a standalone web client](http://floydpink.github.io/Mantis-CI-www/) as well as [an Android apk](https://github.com/floydpink/Mantis-CI). Since I didn't have a Mac at the time, these two were the only ones for then. 

After iterating the porting of the views one by one for a while, on April 11, 2013 the first usable version of the Android, v0.6.0, got published to Google Play and people started downloading and using it! It was exhilarating.

### iOS

In just over a month's time my wife gifted me a surprise Macbook Pro on my birthday. And within a week's time I was hacking on XCode to try and get [an iOS wrapper](https://github.com/floydpink/Mantis-CI-iOS) going for the same HTMl5 web app. The first version that I managed was submitted in late June to the iOS app store and had the exact same ember.js web app that was in Google Play. But it got rejected after a nail-biting one week of waiting - Apple reckoned there just isn't enough iOS-syness to the app!

Refusing to admit defeat, I went back to each of the mobile views and attempted to make it look more like a native app. The styling/color-palette/icons etc. were given a revamp and the app was submitted a second time to the Apple app store in mid August. This time they reviewed it much faster and deemed it worthy of the app store! My first app was in the iOS App Store. It was more exhilarating that Android probably because of the rejection that came first!

### The latest update - v0.9.5

On this last Tuesday - 09/03/2013, both the apps got another round of update, to version 0.9.5, squashing a few bugs and getting rebranded to the new name - **Mantis CI**.

Please download and install both the Android and iOS flavors of Mantis CI and let me know all your comments either on the store reviews or on twitter - [@menonHari](http://twitter.com/menonHari) or as comments on this blog here. 

The learning I have had from putting together these apps are really immense. I hope there will be some little value they bring to a at least a few of the users in the Travis CI community.

Stay beautiful !
