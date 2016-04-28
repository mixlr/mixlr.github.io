---
layout: post
title:  "5 development principles we strive for at Mixlr"
date:   2016-04-28 12:00:00
author: Rob
categories: development
excerpt: Read about some of the development principles we strive to apply at Mixlr, including early release cycle, highly readable code, and more.
comments: true
image: pi.png
tags: development, testing, code quality, agile
---

<a name="top"></a>
<p class="info_block"><strong>We're hiring.</strong> If you enjoy this post, you might enjoy being part of our team too. <a href="/jobs">Visit the Mixlr jobs homepage</a>.</p>

Since we started Mixlr over five years ago, we've experimented with a lot of different approaches to development.

Here are five principles that we've found particularly valuable over that time.

#### Release early and often. (Even if it’s not perfect yet.)

This is the first rule of the [Agile manifesto](http://agilemanifesto.org/principles.html), but arguably the most important - and even more so when you’ve got a small team, and a big user base.

The Mixlr community has over 45,000 monthly active broadcasters and millions of monthly listeners.

To keep everybody satisfied, we have little choice but to aim to release features and improvements frequently, despite our small team size.

We start at the product design phase, defining clear user stories at the earliest possible opportunity, and then stick with them throughout the development cycle. This helps us to focus on improvements that our users really want, and avoid wasted development time.

When it comes to release, we always favour pushing new code as early as possible.

This doesn't mean that allowing a user’s experience to regress is acceptable, of course. We make careful use of tools like Google Analytics, [Mixpanel](http://www.mixpanel.com), Browserstack and [Airbrake](http://www.airbrake.io) to be sure that won't happen.

But with these safeguards in place, we can allow our community to benefit from new features quickly --- even if they're not quite pixel perfect yet.

And with early release comes early dialog too, which helps us finetune and improve a feature more efficiently than we ever could in a closed QA environment.

#### Readability counts.

Once again, Mixlr’s ultra-low ratio of developers to active users makes this principle crucial for us.

Code is nothing if it isn’t readable --- and readable by others, not just the original developer.

Once again, there’s no simple way to achieve this.

Why write a nested ternary statement, when you can space that logic out onto half-a-dozen lines and make it pulse with clarity and simplicity?

When writing Ruby, is that early return statement triggered by a [dangling conditional](http://seejohncode.com/2012/07/31/ruby-gotcha-single-line-conditionals/) worth sacrificing a clear, fully-indented code path that can be understood at a glance?

Can that variable _really_ not be named a little more descriptively?

These are questions we try to ask of every commit, because if we can create code that’s easy to read, then we’ve probably built something that’s easy to maintain too. And everybody, including our users, benefits from that in the long-run.

#### Keep the code visible.

As [Linus's Law states](http://www.exceptionnotfound.net/fundamental-laws-of-software-development/), enough eyeballs make all bugs shallow.

We try to learn from this at Mixlr in a couple of ways.

Firstly, by encouraging our team to review each other's code on an adhoc basis. Once again, [Slack is a great tool here](http://konrad-reiche.com/2015/12/26/continuous-code-review-with-github-and-slack.html), integrating closely with Github to make the code we commit visible to everybody within seconds.

And secondly, by enabling more formal code reviews and [pair programming](http://guide.agilealliance.org/guide/pairing.html) opportunities whenever possible.

Apart from directly increasing overall code quality, this also all has the advantage of exposing more of our backend infrastructure to our team, which is a great learning opportunity too.

#### If it moves, test it.

Writing automated tests isn’t just about ensuring the code you’re writing right now is solid. It also tends to bring a number of other potential benefits to a project.

For starters, it’s possible to move much, much faster when you’re confident that the changes you’re making have left other parts of an application unaffected. So our users benefit now, and then time and again later too.

Unit testing also naturally tends to engender modular, easy-to-understand code --- something which helps improve the long-term maintainability of a project in ways which are difficult to foresee.

Our Ruby on Rails applications feature comprehensive test suites, and with [the help of Jenkins and Slack](http://tech.mixlr.com/development/2016/02/09/five-ways-to-use-slack-jenkins.html) we keep them at the heart of our day-to-day process.

#### Deployments are frictionless.

If we’re going to release early and often, then we’d better make sure that our deploy process allows it.

We use [Capistrano](http://capistranorb.com/) for all of our main projects, which gives us a common deployment interface that our entire development team is familiar with.

During a recent upgrade to Capistrano 3, we also refactored and modularised all of our deploy hooks, making the system significantly easier to understand and modify.

We use [Matt Brictson’s Airbrussh gem](https://github.com/mattbrictson/airbrussh) to prettify and improve the coherence of the Capistrano output.

Our internal staging site provides us an ideal environment for testing and otherwise experimenting with the deploy process, and tight integration with Slack means that our team always knows who is deploying what to where.

All of this means that our entire team is comfortable with deploying to production (often from their very first day with us), so we can fix bugs quicker and deploy new features more readily than we would otherwise be able to.

Read more: [How to deploy software](https://zachholman.com/posts/deploying-software)


