---
layout: post
title: "AOP for logging in .NET"
date: 2012-12-16T11:23:00-08:00
comments: true
categories:
- technical
- cross-cutting concerns
- .NET
- aspect oriented programming
- StructureMap
- instrumentation
- logging
- Castle Dynamic Proxy
- tracing
- AOP
- log4net
published: true

---

Implementing the AOP pattern into a C# .NET application is something I always wanted to do. I had tried PostSharp with a few other team members, a while ago, but could not get it working soon enough, that we quit the attempt after a while.

After reading up a little more (here, here and here) I am now trying it all over again in the Flickr Downloadr that I am now working on.

I still haven’t completely cracked it, because the Flickr Downloadr WPF app heavily uses the new asynchrony features (async/await etc.) from .NET 4.5. I hope to somehow adapt the dynamic proxy based intercept paradigm to make it work with the new asynchronous model soonand I shall follow this up here then with the details.

<!-- more -->Meanwhile, here’s the solution on GitHub (as tag v0.1) that is a proof-of-concept console app, which calls into two separate service classes. As long as there are no asynchrony features from .NET. 4.5 in your app, you should be able to make use of this pattern.

There is some business specific logging (what I call organic logging )happening inside one of these service classes themselves. But there is also code enables aop logging of all the entry and exit into every method in these pseudo- business objects.

The main method that does the AOP magic is the Intercept method of the IInterceptor interface.
{% gist 4315686 %}
It could peep into the method being called, its arguments, its return type etc. through the invocation instance, do things like logging and then make the real call to the real invocation. The try/catch that is implemented at this level could be the only place that happens. Auditing, authentication etc. could also be implemented at this layer to affect all the classes/methods one chooses.

