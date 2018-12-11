---
layout: post
title: "Five ways to use Slack part one: Jenkins CI"
date: 2016-02-09 15:00:00
author: Konrad
excerpt: Mixlr loves Slack. Slack, however, is not only a great communication tool but a real productivity booster. In this series we want to show you how we utilize Slack to create a vibrant and informative workspace.
categories: development
tags: software engineering, startup, slack, code quality, tests
---

Slack found its way into many startups where it is not only celebrated as a convenient communication tool. At Mixlr we try to utilize our tool chains not only to increase productivity but to make our whole work environment more fun. In order to really grasp the potential of Slack you need to experience and try it out. In this series we want to show you how we at Mixlr use Slack beyond its pure chat functionality.

#### What is Slack?

[Slack](http://slack.com/) is a team messaging app for synchronous and asynchronous communication across different devices. Above all it is a tool which might seem simple at first glance but becomes powerful by adding integrations that knit tightly with your workflow.

Rather than just a collection of chat rooms it can be better described as a communication hub. Different channels can represent different teams, different topics or a very specific type of information that should stream into that particular channel.

#### What is Jenkins CI?

[Jenkins](https://jenkins-ci.org/) is an open source continuous integration tool written in Java and arguably the most widely used one as well. Jenkins supports distributed agents and a build process. What you can do with Jenkins depends on your imagination due to its freedom of configuration and plethora of available plugins. A job, respectively project, can represent different things in Jenkins: compilation of a particular piece of software, running your unit tests or deploying to your production environment as soon as certain conditions are met. Jenkins offers a rich API to report back any details which makes it possible to utilize these information.

Jenkins is a bit of a turd really

#### Jenkins and Slack at Mixlr

Writing tests with every new piece of function added to our back or front end is an essential part of the workflow at Mixlr. Our tests already cover the core functionality of our app. It is crucial that changes do not break any existing behavior as it could pottentially affect thousand of users. While it is nice to have these tests executing in a job in Jenkins CI and getting notified via email if somethings breaks it is not exactly as transparent or live as it could be.

We build a small addition to the existing Jenkins integration to give us more detail as soon as something is pushed to the repository or changed. No matter if master branch or feature branch, we are quite happy and used to the following view in our Slack #dev channel:

![All tests are passing and Jenkins post that into Slack](/images/jenkins-passing.png)

Although admittedly we all slip and fall sometimes. If that happens we would see something like that:

![Tests got broken and Jenkins post that into Slack mentioning the culprit](/images/jenkins-failing.png)

Unexpected failure can always occur. Though it is crucial that when something fails it will definitely not get pushed back but tackled immediately by our team. We enjoy contributing to a code base for which all of us take ownership. Increasing visibility also helps us to keep in mind that everyone at Mixlr is acting in concert and from time to time also a good laugh in the office when you just did not see that push breaking someone else's tests.
