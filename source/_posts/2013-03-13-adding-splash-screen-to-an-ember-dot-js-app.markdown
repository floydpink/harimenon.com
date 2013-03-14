---
layout: post
title: "Adding splash screen to an Ember.js app"
date: 2013-03-13 19:48
comments: true
description: "Add a custom splash screen for an Ember.js application, that could be especially usefult if it's deployed as mobile apps."
keywords: "splash, screen, mobile splash screen, ember.js, ember.js app splash, ember.js splash, ember splash"
categories: [technical]
---

Have been playing around with [Ember.js](http://emberjs.com) quite a bit lately and it's been real good fun. I have been trying to put together a [PhoneGap/Cordova](http://cordova.apache.org/) based Android app, for the awesome, open source, continuous integration application - [Travis-CI](http://travis-ci.org). It is really in its pre-natal stages, but you could see whatever I've been doing [here](https://github.com/floydpink/Travis-CI).

And I implemented a splash screen for that app using the below technique.

``` javascript
var App = Ember.Application.createWithMixins({
    LOG_TRANSITIONS: true,
    init: function () {
        this.deferReadiness();
        this._super();
    }
});

App.Router.map(function () {
    this.resource('splash');
    this.resource('main');
    this.resource('sub');
});

App.IndexRoute = Ember.Route.extend({
    redirect: function () {
        var seenSplash = $.cookie('seen-splash');
        if (!seenSplash) {
            $.cookie('seen-splash', "true");
            this.transitionTo('splash');
        } else {
            this.transitionTo('main');
        }
    }
});

App.SplashRoute = Ember.Route.extend({
    enter: function () {
        var widthOrHeight = $(window).height() > $(window).width() ? 'width' : 'height';
        $('#splash-content').find('img').css(widthOrHeight, '70%');
        $('#splash').fadeIn();

        Ember.run.later(this, function () {
            $('#splash').fadeOut().detach();
            this.transitionTo('main');
        }, 1500);
    }
});

App.MainController = Ember.Controller.extend({
    clearCookie: function () {
        $.cookie('seen-splash', null);
        console.log('cleared session cookie');
    }
});

App.advanceReadiness();
```

These are the versions of jQuery, Ember and Handlebars this was tested with:

``` plain
DEBUG: -------------------------------
DEBUG: Ember.VERSION : 1.0.0-rc.1
DEBUG: Handlebars.VERSION : 1.0.0-rc.3
DEBUG: jQuery.VERSION : 1.9.1
DEBUG: -------------------------------
```

You could find this in action [on jsfiddle](http://jsfiddle.net/FloydPink/73GBx/).

Please leave a comment if you found this useful! :)