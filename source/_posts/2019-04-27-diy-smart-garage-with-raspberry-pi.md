---
layout: post
title: DIY Smart-Garage with Raspberry Pi
comments: true
date: 2019-04-27T09:50:00-04:00
description: "Converting a regular remote controlled garage door into a DIY, Alexa-controlled smart garage using a Raspberry Pi and a couple of open-source apps."
keywords:
 - smart garage
 - raspberry pi
 - alexa
 - python
 - javascript
 - node.js
 - soldering
 - diy
categories:
 - technical
tags:
 - smart garage
 - raspberry pi
 - alexa
 - python
 - javascript
 - node.js
 - soldering
 - diy
published: true
---

## Summary

We have a detached garage that opens into the alley behind our home and it has always been difficult to quickly tell from within the house if the garage door is currently open or closed. And this is something that I really wanted to fix with some sort of DIY hacks, right from the very first day we started living in our home.

Sometime in early March, the garage door began having another problem - closing it with one of the remotes or with the wall-switch begins with the closing, but immediately stops and backs out after closing a few inches. I later diagnosed this to be an issue with misaligned/dirty sensors and have rectified it.

But that problem energized my desire to start a DIY project to convert my plain old, "builder quality" garage door opener (which is _Chamberlain HD400DM_) to a "**smart one**".

<!-- more -->

## Research

I have some experience with a Raspberry Pi - I have configured one to be to used as my backup/file/print/media server along with [an open-source Python app/daemon](https://github.com/eclair4151/AlexaControlledSamsungTV) on it that helps control our Samsung TV with Alexa. So my search keywords were along the lines of "raspberry pi smart garage", "detect garage door state" etc.

These helped me discover a couple of well-documented open-source apps/projects that seemed really fitting:

1. [rllynch/pi_garage_alert](https://github.com/rllynch/pi_garage_alert)
2. [chasechou/node-garagepi](https://github.com/chasechou/node-garagepi)

The first one, written in Python, enables attaching [a magnetic switch/sensor](https://smile.amazon.com/gp/product/B00CAIVNM4/) to the door and sends out alerts as texts/emails/tweets etc., when the door has been open for 'x' number of minutes. This is done by configuring Raspberry Pi's [GPIO](https://www.raspberrypi.org/documentation/usage/gpio/) to the magnetic sensor.

The second one, written originally in Python and later converted into Node.js, enables using a Raspberry Pi camera module to visually inspect the garage door along with a GPIO-controlled [2-channel relay](https://smile.amazon.com/gp/product/B0057OC6D8/) soldered on to a Garage Door Opener remote, to open and close the door via an intranet web app.

I realized that combining these two will help me to implement all these features into my "**smart garage**":

1. check a web app to see if the door is open or closed (via the camera)
2. click on a button on the same web app to open/close the door
3. receive email/text when the door stays open for 'x' minutes

## Custom Enhancements

After seeing these, the idea of creating an Alexa skill germinated. The skill should be able to:
1. control the garage door as well as to
2. check the current state of the door (programmatically rather than "looking" through the camera)

And for this, I made these additional changes:

 - added [an optional feature](https://github.com/rllynch/pi_garage_alert/pull/8) to the Python-based `pi_garage_alert` service to write the state of the door when it changes to a text file somewhere on the Pi.

 - made a similar change into the Node.js-based `node-garagepi` to read the same text file and to return from a `GET status` endpoint.

 - developed a custom Alexa skill along with another Node.js web-service to make the whole thing voice-controlled

## Implementation

Essentially, the implementation involved following these detailed write-ups from the authors of the two services mentioned above:

1. [Making Your Garage Door Email, Tweet, or SMS](https://www.richlynch.com/2013/07/27/pi_garage_alert_1/)
2. [Raspberry Pi Garage Door Opener with GaragePi](https://coderwall.com/p/jsd5mw/raspberry-pi-garage-door-opener-with-garagepi)

The minor changes that I made to both of these projects - like the changes to make them both talk to each other, upgrading the outdated dependencies, converting to the latest version of JavaScript etc. - are all currently in private repositories.

And the custom Alexa skill itself is not currently published to the store since the URL to the publicly available web-service that Alexa calls, is "hard-coded" in the present form. So the source code for the custom skill and the web-service that Alexa calls are also currently in private repositories.

The project taught me a few new things, made me do a little bit of wiring and [some crude soldering](https://twitter.com/menonHari/status/1110390580373262341), cost around $130 in all and was a lot of fun. And our garage door can now be opened/closed with Alexa!

If there is enough interest, I shall clean-up and open-source all of these currently private repos along with a more detailed walk-through of implementing this "smart garage".

## Thank you!

Thank you for your time - please let me know your thoughts via the comments below.
