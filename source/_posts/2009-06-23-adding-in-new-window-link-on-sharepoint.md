---
layout: post
title: "Adding a 'Open in a new window' link on SharePoint document libraries"
date: 2009-06-23T09:29:00-07:00
comments: true
categories:
 - technical
tags:
- original
- new window
- WSS 3.0
- document library
- sharepoint
- MOSS 2007
- jQuery
- JavaScript
published: true
---

A recent requirement from the client on the project I am working on was to add a new window link on the Report Libraries on a SharePoint Report Center site, that had the reports (*.rdl) generated and deployed from SQL Server Reporting Services (SSRS). The SSRS Report Viewer web parts were being used, but the reports were also being viewed directly from the report libraries to which they are deployed. By default, the link to the report in a Reports Library (for that matter, any document in a SharePoint document library) opens it in the same window, and this was what they wanted to change.

It is the in-built document library web part that renders all the documents and folders in a document library and that is where the change should be made. Rather than touching any of the core components in SharePoint I analysed the feasibility of using jQuery through a content editor web part (thanks to [Christophe](http://pathtosharepoint.wordpress.com/)) and was able to get it work.

All one has to do is, edit the AllItems.aspx page of the desired document library from the browser, to add a content editor web part and add the below code within the source editor: {% gist 4218866 %}

Hope this would help someone.
