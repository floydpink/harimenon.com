---
layout: post
title: "Auto-deploying to my Octopress blog with Travis-CI"
comments: true
categories: [technical, blog, Octopress, Travis-CI]
published: true

---

A couple weeks earlier, [Sergey Klimov](http://darvin.github.com/) (who is [@darvin](https://github.com/darvin) at GitHub) opened the [issue #940](https://github.com/imathis/octopress/issues/940) at [imathis/octopress](https://github.com/imathis/octopress), which is more a feature suggestion than an issue.

Within that, he has linked to [his detailed blog post](http://darvin.github.com/blog/2013/01/13/Prose_Octopress_TravisIO/ "Prose.io + Octopress + Travis-CI + GitHub Pages = ♥") suggesting how the awesome [Travis-CI](https://travis-ci.org/) could be configured to do the `rake generate` and `rake deploy` for you, when you add/update new posts to an [octopress](http://octopress.org/) blog, even from browser-based editors like either the built-in GitHub editor, or a third-party tool like the [prose.io](prose.io) editor (which is really awesome too, BTW).

For the uninitiated, Travis-CI is a really nice, open source, free and hosted continuous integration service that could build and run the unit tests for you, on every commit to a GitHub repository. It supports projects in a multitude of languages, as seen [here](http://about.travis-ci.org/docs/user/getting-started/#Travis-CI-Overview). The service allows you to configure steps that would be run [before, after and during the build and test process](http://about.travis-ci.org/docs/user/build-configuration/), with just one [YAML](http://www.yaml.org/ "YAML Ain't Markup Language") file (named `.travis.yml`) in the root of your repo. Apart from running the many unit tests in the project and letting you know how your latest check-in affected the health of the project, the Travis-CI service could also do custom build tasks like a post-build deployment. And this is what Sergey has tappped into, for use with the deployment of an Octopress blog.

His blog post really has everything that one would need to set-up Travis-CI for automating the deployment of their blog. This post here is trying to add a couple of tweaks that were done, when I [successfuly enabled](https://travis-ci.org/floydpink/harimenon.com) auto-deploy for [this blog](/blog) of mine, the source of which can be seen at [floydpink/harimenon.com](https://github.com/floydpink/harimenon.com). (Also, this very post, is in-fact composed on a browser, thanks to [prose.io](http://prose.io/#floydpink) service).

#### 1. Revert _config.yml

As the `before_script` is using `rake setup_github_pages` task every time on Travis to setup the _deploy git correctly, it was overwriting the `_config.yml` `url` value to the github `url`, which would be a problem, if like me, you are deploying this to a custom domain.
``` diff _config.yml
 #      Main Configs       #
 # ----------------------- #

-url: http://www.harimenon.com
+url: http://floydpink.github.com/harimenon
 title: Hari Menon
 subtitle: Namaste. Welcome to my personal space on the world wide web!
 author: Hari Menon
```
This subtle little thing was manifest only in the tweet button behavior (which fortunately, I noticed when I was trying to tweet this very post) as seen in this screenshot:
[{% img http://i.imgur.com/jLAFiwl.png 'Tweet button behavior' 'Tweet button behavior' %}](http://i.imgur.com/jLAFiwl.png)
Instead of the correct URL - `http://www.harimenon.com/blog/2012/12/16/aop-for-logging-in-net/`, the tweet was showing - `http://floydpink.github.com/harimenon/blog/2012/12/16/aop-for-logging-in-net/`.

To fix this, we should add an additional line to revert the `_config.yml` (especially for the blogs that are hosted with cutom URLs).

``` diff .travis.yml
   - echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
   # Set deployment target to github pages
   - rake setup_github_pages[$REPO]
+  # To reset the 'url' to the custom domain in '_config.yml'
+  - git checkout -- _config.yml
 script:
   # Generate site
   - rake generate
```

#### 2. Add [ci skip] to the commit message

As a _P.S._ to his blog post, Sergey talks about how Travis builds the project twice once for the original commit (with the intended changes to the blog) and second because of the commit from the `rake deploy` applied by this first Travis build (all of this is because, it seems the `branches` [setting](https://gist.github.com/4522846#file-travis-yml-L1) in the `.travis.yml` that limits it to the `source` branch only does not seem to work). And he has [a clever workaround](https://gist.github.com/4522846#file-travis-yml-L22) in the `after_script` to stop this at the second build itself rather than going into an infinite loop - `'echo ''script: "ls *.html"'' > public/.travis.yml'`. I tweaked this a little bit as below:

From one of the earlier encounters, I remembered that the [Travis-CI documentation](http://about.travis-ci.org/docs/user/how-to-skip-a-build/) does detail how a specific commit could be made to skip the ci build. Just by including `[ci skip]` (including the brackets) somewhere in the commit message. So the first tweak I did is this in the `Rakefile`:

``` diff Rakefile
     system "git add ."
     system "git add -u"
     puts "\n## Commiting: Site updated at #{Time.now.utc}"
-    message = "Site updated at #{Time.now.utc}"
+    message = "Site updated at #{Time.now.utc} [ci skip]"
     system "git commit -m \"#{message}\""
     puts "\n## Pushing generated #{deploy_dir} website"
     system "git push origin #{deploy_branch} --force"
```

#### 3. Syntax changes in using the travis command line tool to encrypt deploy key

Also, because I had to upgrade to the latest version of the Travis, which has slightly different command-line syntaxes now, I had to tweak [the script he has referred to](https://gist.github.com/4242707), to generate the `secure` argument for the deploy key. My version is as below:
{% gist 4631240 %}
The difference essentially is only in the `ENCRYPTION_FILTER` environment variable, that holds the way the `travis` command line client would be used to generate the encrypted deploy key.

One more occasion, where I feel like I have done something _a la_ a dwarf standing on the shoulders of giants.