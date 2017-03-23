---
layout: post
title: "Displaying the version for a Microsoft InfoPath 2007 form template"
date: 2009-08-26T12:25:00-07:00
comments: true
categories:
 - technical
tags:
 - version
 - infopath
 - sharepoint
 - form template
published: true

---

Add an expression box that has the below expression and Voila!

``` plain
substring-before(substring-after(/processing-instruction()[local-name(.) = "mso-infoPathSolution"], 'solutionVersion="'), '"')
```