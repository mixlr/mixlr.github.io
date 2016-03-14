---
layout: post
title: "Five ways to use Slack part two: How we made Campfire sounds work in Slack"
date: 2016-03-14 18:30:00
author: Konrad
excerpt: In this series we show you how Mixlr pushes Slack beyond its boundaries. How we let the genie out of the bottle--into the office and made Campfire sounds and more, work in Slack.
categories: development
tags: software engineering, startup, slack, code quality, tests
---

In this series we show you how Mixlr pushes Slack beyond its boundaries. How we let the genie out of the bottle--into the office. One of the features that made Campfire, the real-time chat communication tool for team collaboration, indistinguishable is the feature to play sounds to everyone. From sounds like _danger zone_ from Topgun, over George Takei's _oh my_, to _roll out_ by Ludacris there is a sound to emphasise every kind of situation; be it a colleague spilling coffee over your laptop or a successful rollout of a new feature, there is a sound for it.

After Mixlr migrated to Slack we found ourselves becoming more and more productive with every new integration we added but the lack of sounds was a wound which would not heal. We are taking great pride in our office stereos as it not only enables us to listen to music, share new discoveries but also use our product in a communal way. There is this notion of the Raspberry Pi, which simply screams office hack!

### Connect it, start it, play it

Since we also get everything set up through a mix deck it would be just a matter of connecting the Raspberry Pi via line out to the mix deck in order to make any output sounds available while maintaing our office music sounds. Slack allows you to define outgoing webhooks or even specific commands. For instance, you would specify the following command:

```
/sound [name]
```

and enter an endpoint to which the Slack service should post the provided data to. Maybe you can already guess how everything fits together. We let Slack post that message directly to our Raspberry Pi which then in turn would trigger the sounds using `mpg123` (Figure 1).

![A Slack command triggers the Slack webhook to post to our Raspberry Pi which then in turn plays a sound on our office speakers](/images/slack-sounds-diagram.png)

It is such a simple setup but if you think about it opens up so many possibilities in terms of extension. For instance, setting a time to play coffee or tea sounds when the brew is done. For us this is just the start as we have also hooked our office screen to the Raspberry Pi to display server health and project statuses. It can be clearly said that even with these small things you can spawn fun things with a bit of creativity and even though it does not always directly improve our product it heavily improves our day to day happiness and you never know when one of these hacks lead to another innovative idea as well.

![Mixlr's Raspberry Pi connceted to our mix deck](/images/slack-sounds.jpg)
