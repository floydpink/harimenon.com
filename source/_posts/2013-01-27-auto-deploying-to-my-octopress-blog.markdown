---
layout: post
title: "Auto-deploying to my Octopress blog with Travis-CI"
comments: true
categories: [technical, blog, Octopress, Travis-CI]
published: true

---

A couple weeks earlier, [Sergey Klimov](http://darvin.github.com/) (who is [@darvin](https://github.com/darvin) at GitHub) opened the [issue #940](https://github.com/imathis/octopress/issues/940) at [imathis/octopress](https://github.com/imathis/octopress), which is more a feature suggestion than an issue.

Within that, he has linked to [his detailed blog post](http://darvin.github.com/blog/2013/01/13/Prose_Octopress_TravisIO/ "Prose.io + Octopress + Travis-CI + GitHub Pages = ♥") suggesting how the awesome [Travis-CI](https://travis-ci.org/) could be configured to do the `rake generate` and `rake deploy` for you, when you add/update new posts to an [octopress](http://octopress.org/) blog, either from the built-in GitHub editor, or using a third-party editor like [prose.io](prose.io) (which is really awesome too, BTW) and commit them.

For the uninitiated, Travis-CI is a really nice, open source, free and hosted continuous integration service that could run the unit tests for you, on every commit to a GitHub repository. The service allows you to configure steps [before, after and during the build and test process](http://about.travis-ci.org/docs/user/build-configuration/) that would be run, with just one [YAML](http://www.yaml.org/ "YAML Ain't Markup Language") file (named `.travis.yml`) in the root of your repo.

Apart from running the many unit tests in the project and letting you know how your latest check-in affected the health of the project, the Travis-CI service could also do custom build tasks like a post-build deployment. And this is what Sergey has tappped into, for use with an Octopress blog.

His blog post really has everything that one would need to set-up Travis-CI for automating the deployment of an octopress blog. This post here is only trying to add a couple of tweaks that were done, when I [successfuly enabled](https://travis-ci.org/floydpink/harimenon.com) auto-deploy for [this blog](/blog) of mine (the source of which is over at [floydpink/harimenon.com](https://github.com/floydpink/harimenon.com)). (Also, this very post, is in-fact composed on a browser, thanks to [prose.io](http://prose.io/#floydpink) service).

As a _P.S._ to his blog post, Sergey talks about how Travis builds the project twice once for the original commit (with the intended changes to the blog) and second because of the commit from the `rake deploy` applied by this first Travis build (all of this is because, it seems the `branches` [setting](https://gist.github.com/4522846#file-travis-yml-L1) in the `.travis.yml` that limits it to the `source` branch only does not seem to work). And he has [a clever workaround](https://gist.github.com/4522846#file-travis-yml-L22) to stop this at the second build itself rather than going into an infinite loop:

``` yaml after_script
after_script:
  # Workaround for travis not to try run rake on generated site
  - ! 'echo ''script: "ls *.html"'' > public/.travis.yml'
  # Deploy!
  - rake deploy
```

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

Also, because I had to upgrade to the latest version of the Travis, which has slightly different command-line syntaxes now, I had to tweak [the script he has referred to](https://gist.github.com/4242707), to generate the `secure` argument for the deploy key. My version is as below:
{% gist 4631240 %}
The difference essentially is only in the `ENCRYPTION_FILTER` environment variable, that holds the way the `travis` command line client would be used to generate the encrypted deploy key.

One more occasion, where I feel like i have done something _a la_ a dwarf standing on the shoulders of giants.