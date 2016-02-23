---
layout: post
title:  "10 open source technologies we use at Mixlr"
date:   2016-02-02 12:00
author: Rob
image: mixer.png
categories: development
excerpt: How do we build Mixlr? In this post we talk about ten open source technologies that make Mixlr possible.
comments: false
tags: backend technology lists
---

<a name="top"></a>
<p class="info_block"><strong>We're hiring.</strong> If you're a backend developer who is passionate about building rock-solid, high-availability systems using open source technology, you may find Mixlr to be a great team to join. <a href="/jobs">Visit the Mixlr jobs homepage</a>.</p>

We rely on a host of amazing open source technologies to build the Mixlr platform. This post offers an overview of some of our favourite examples, and why they play such a big part in building our service.

1. [PostgreSQL](#postgresql)
1. [Redis](#redis)
1. [Nginx](#nginx)
1. [Haproxy](#haproxy)
1. [Lua](#lua)
1. [Puppet](#puppet)
1. [Ruby](#ruby)
1. [Ruby on Rails](#rails)
1. [NodeJS](#nodejs)
1. [Jenkins](#jenkins)

#### PostgreSQL<a name="postgresql"></a>

PostgreSQL has been our main database since we migrated away from MySQL in early 2015.

Our experiences with Postgres so far have been very positive, especially bearing in mind that after five years of running a fast-growing startup we have a _lot_ of data to deal with.

Even when working with tables containing hundreds of millions of rows, Postgres allows us to continue carrying out many routine administration tasks - such as adding or removing columns or building indexes - without locking tables and forcing our service offline. This is an area that MySQL in particular is notoriously deficient in, and had previously caused our development team numerous pulsating headaches.

Postgres has other advantages too: helpful `EXPLAIN` output, advanced constraints and a host of custom cell types for modelling data like IP addresses, JSON and complex container types, to name but a few.

* [PostgreSQL homepage](http://www.postgresql.org/)
* [What are the pros and cons of PostgreSQL and MySQL?](https://www.quora.com/What-are-pros-and-cons-of-PostgreSQL-and-MySQL)
* [Back to top](#top)

#### Redis<a name="redis"></a>

This fast, stable and elegant example of open source software powers many things at Mixlr. From acting as a short-term caching layer a la [Memcached](http://memcached.org/), storing sessions for our web application, or acting as a [pubsub server](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) delivering real-time messages to tens of thousands of client applications - it just works.

If there's one thing not to love about Redis, it's just a little bit _too_ versatile. As with Maslow's hammer, there is a tendency for everything to start to look like a candidate for storing or processing in Redis - even when there are better options for data persistence readily available. For this reason, we are careful to never put data into Redis that we wouldn't be too unhappy to lose without warning.

The [Redis source code](https://github.com/antirez/redis) is regularly hailed as an example of concise, well-written C.

* [Redis homepage](http://redis.io/)
* [Using Redis at Pinterest for billions of relationships](https://blog.pivotal.io/pivotal/case-studies/using-redis-at-pinterest-for-billions-of-relationships)
* [Back to top](#top)

#### Nginx<a name="nginx"></a>

Nginx has quickly usurped Apache to become the most popular front-end web server in the world. It is also responsible for serving almost every HTTP request received by the Mixlr website, API and backend services.

Its event-driven design makes serving static files, assets and images incredibly pain-free.

And its modular configuration system allow us to easily optimise, secure and otherwise polish every part of our website and API.

Let's not forget its integration with the Lua scripting language, discussed more [below](#lua).

* [Nginx homepage](https://www.nginx.com/)
* [Why is Nginx so efficient?](https://www.quora.com/Why-is-nginx-so-efficient)
* [Back to top](#top)

#### Haproxy<a name="haproxy"></a>

Sticking with HTTP processing tools, The Haproxy loadbalancer is another essential part of our infrastructure.

Although Nginx provides some duplicate functionality, Haproxy's low-level and fine-grained configurability allow us to make the most of a relatively small pool of backend Ruby on Rails servers. This avoids most unnecessary backlogs forming when proxying requests, meaning our users are much more likely to be served the content they want as quickly as possible.

And of course a smaller pool of backend servers saves us a bunch of money and time too.

Much like Redis, it's also another great example of a highly efficient, elegant tool that just works.

* [Haproxy homepage](http://www.haproxy.org/)
* [Stackoverflow update: 560M page views a month, it's all about performance](http://highscalability.com/blog/2014/7/21/stackoverflow-update-560m-pageviews-a-month-25-servers-and-i.html/)
* [Back to top](#top)

#### Lua<a name="lua"></a>

Lua is a compact, powerful (and characterful) scripting language. It's so small that it's become a de facto choice for embedded systems, making appearances in many [games](https://en.wikipedia.org/wiki/Category:Lua-scripted_video_games) and industrial software packages.

For Mixlr, its allure is in its ability to be embedded in the Nginx web server. Lua code can be triggered at numerous points of the Nginx request/response cycle, giving us arbitrary programmatic access to the entire Nginx environment (not to mention external HTTP services, Redis, and more).

The possibilities here are clearly many - others have even implemented [entire web application frameworks](https://openresty.org/) using Nginx and Lua.

We don't go quite that far, but we do make use of Lua to further fine-tune our HTTP services, implement [advanced page-caching strategies](http://tech.mixlr.com/development/2016/01/25/how-to-handle-csrf-token-when-page-caching.html), and a lot more besides.

* [Lua homepage](http://www.lua.org/about.html)
* [Nginx/Lua module](https://github.com/openresty/lua-nginx-module)
* [Pushing Nginx to its limits with Lua](https://blog.cloudflare.com/pushing-nginx-to-its-limit-with-lua/)
* [Back to top](#top)

#### Puppet<a name="puppet"></a>

Mixlr would likely not exist in its current form today if it wasn't for Puppet. We use the configuration management system to define each and every one of our backend servers: what software and updates are installed, the location and content of configuration files, cron jobs, iptables rules, and lots more besides.

The value of Puppet comes in the time we save each time we deploy a new server. Instead of a day of manual and error-prone effort, spinning up a new box typically takes just minutes - and is repeated precisely, each and every time.

Unlike alternative Chef, Puppet has a declarative approach to configuration - a limitation we've found has actually been a positive influence in keeping our Puppet manifests simple and easy to understand.

Puppet is also at the heart of our autoscaling systems, allowing our service to respond quickly and automatically to unexpected spikes in traffic.

* [Puppet homepage](https://puppetlabs.com/)
* [Configuration management software - which should I choose?](https://www.quora.com/Configuration-Management/Which-should-I-choose-Chef-Puppet-Ansible-SaltStack-Docker-or-something-else)
* [Back to top](#top)


#### Ruby<a name="ruby"></a>

Hailing from Japan, the popularity of the Ruby programming language has exploded over the last decade, mostly powered by its adoption by web developers across the world.

Ruby deserves being appreciated as a great open source project in its own right, however. The brainchild of Yukihiro Matsumoto - aka Matz - it is slightly idiosyncratic in style, infinitely flexible and - in the right hands - a profoundly powerful tool that's also relatively easy to learn.

One of Ruby's most distinguishing features is its aptness for creating [domain-specific languages](http://martinfowler.com/books/dsl.html) - small, specialised and efficient interfaces to sub-parts of a particular software system or application. At Mixlr we've used Ruby to build a DSL which defines our internal API, for example.

Ruby code also glues most of the Mixlr backend infrastructure together, its transparent interoperability with kernel and shell level functionality making it a great fit.

* [Ruby homepage](https://www.ruby-lang.org/)
* [Learn Ruby the hard way](http://learnrubythehardway.org/book/)
* [Back to top](#top)

#### Ruby on Rails<a name="rails"></a>

The world's most opinionated web framework powers Mixlr's website, API and internal tools.

Rails turns building web applications into an incredibly productive pursuit, helped by its preference for convention over configuration - meaning the days of endless XML configuration files are thankfully (largely) behind us.

And then there's the small matter of an active and highly passionate community, and a [huge library of third party libraries](https://rubygems.org/), aka gems, to make development easier.

* [Ruby on Rails homepage](http://rubyonrails.org/)
* [Learn Rails at Codecadamy](https://www.codecademy.com/learn/learn-rails)
* [Back to top](#top)

#### NodeJS<a name="nodejs"></a>

NodeJS burst into life in 2009, when Ryan Dahl got [tired of trying to do non-blocking I/O in Ruby](https://www.youtube.com/watch?v=ztspvPYybIY) and decided to write his own JavaScript-based, C++-powered event-driven network programming framework.

Perfect for building low-latency, high-performance systems, we use NodeJS in two main applications: powering our real-time messaging services (which provide chat and other social features on Mixlr, amongst many other jobs) and also in a suite of custom audio streaming servers.

The power and flexibility of NodeJS means it will likely play a big role in the future of our infrastructure.

* [NodeJS](https://nodejs.org/)
* [NodeJS in flames at Netflix](http://techblog.netflix.com/2014/11/nodejs-in-flames.html)
* [Back to top](#top)


#### Jenkins<a name="jenkins"></a>

One of the most recent additions to this collection, Jenkins is an "_open source automation server_" - also known as a [continuous integration tool](https://www.thoughtworks.com/continuous-integration). Like many others, we use Jenkins to automate the running of unit and functional tests on our main Rails applications.

Jenkins makes it possible to automatically trigger a full test run every time one of our development team pushes a new change to GitHub. This simple but poweful behaviour, combined with clever integration with Slack, has profoundly increased the usefulness of the tests by making it impossible for anybody to not know they are failing.

Watch this space for more information about the impact Jenkins has been having on our daily workflow.

* [Jenkins homepage](https://jenkins-ci.org/)
* [What is Jenkins? When and why is it used?](https://www.quora.com/What-is-Jenkins-When-and-why-is-it-used)
* [Back to top](#top)

#### Next...?

We're hiring backend developers, and you soon be adding to this list yourself. Interested? [Visit the Mixlr jobs homepage](/jobs) to find out more.
