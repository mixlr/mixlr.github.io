---
layout: post
title:  "Shuffling playlists in the Mixlr app"
date:   2016-02-09 16:54:00
author: Daven
categories: development
excerpt: A walkthrough of how playlist shuffling is performed in the Mixlr desktop app using random sampling. This technique is a universal method that can be applied to many different problem domains.
comments: true
tags: Monte Carlo, shuffle, shuffling, playlist, random
---

<p class="info_block"><strong>We're hiring!</strong> Are you a developer who wants to work on interesting technical challenges with a small, passionate team here in London? We'd love to chat more: drop us a line via <a href="mailto:jobs@mixlr.com">jobs@mixlr.com</a>.</p>

Playlist shuffle was a feature added to the Mixlr desktop app in 2015 after popular demand from users.
Shuffling can be approached in different ways from a technical perspective, but is hard to get "right" from a user perspective.
Youtube solves the problem by randomly sorting the playlist, which may be fine for a youtube listener playlist, but a Mixlr broadcaster probably wouldn't want their lists being randomly rearranged.
If you can think back to the way Winamp performed with shuffled tracks in a playlist, you may have had an experience where one of your [favourite tracks never seemed to play](https://thetfp.com/tfp/tilted-technology/60783-how-does-winamps-shuffle-work.html).

![Shuffle control in the Mixlr desktop app](/images/shuffle.png)

At Mixlr we wanted to nail the user experience for shuffling, using a high quality (in terms of bias) algorithm/technique.
The shuffle feature was well received, and we would like to share our method for both learning and re-use; please read on for the juicy details.


####Getting the shuffle right

Writing an algorithm to perform a shuffle, at first thought, sounds quite easy.
A quick solution might involve selecting a random number from <span>$$1$$</span> to <span>$$N$$</span> (where <span>$$N$$</span> is the number of tracks you have loaded in your playlist) and choosing that track to play. 
This process could simply be repeated to select the next track. Sounds OK in principle, but it's not actually a good solution for several reasons:

* The shuffle is biased, in the worst case it could result in one track being played more than others, whilst another track rarely gets played.
* Each track has a fixed (and biased!) probability of playback. That means there's a possibility that one track could be selected multiple times in a row.
* There is no control over the probability - i.e. to manipulate the selection likelihood of a particular track

There are algorithms available for shuffling that solve the biasing issue (e.g. the [Fisher-Yates-Knuth shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle)).  
However, we want more control over the shuffle to subjectively increase the quality of track playback order from a human perspective. 

####The shuffle experience

Shuffling in a way that "feels right" is a challenge in and of itself; having a intuitive user experience would have to inform algorithm design.
There were certain requirements: 

* Randomness - a proper random selection rather than a playlist sort. Because it feels more authentically random if you hear a track repeated in a short period.
* Controlling repetition - yes we want randomness, but not to the point of annoyance. It should be much less likely (but still possible) to hear the same track repeated in a short period.
* All tracks matter - if we have <span>$$N$$</span> tracks, and <span>$$N - 1$$</span> different tracks have played, it should be much more likely to select the track <span>$$T_N$$</span> which hasn't played, rather than the previously selected track <span>$$T_{\mu}$$</span>.

These requirements mean that this problem is different to shuffling a pack of cards.
We need to assign and compute the probability of each track playing and make a random selection based on all probabilities (i.e. a type of [stochastic roulette wheel selection](http://stackoverflow.com/questions/177271/roulette-selection-in-genetic-algorithms)).

####Shuffling using random sampling

Random sampling in general is a method that is straightforward to understand and implement.
Here are the major stages to our approach:

> 1. Assign every track a probability - in our case start the integer <span>$$N$$</span> (where $$N$$ is total the number of tracks).
> 2. Pick a random number in the range <span>$$[0.0, 1.0]$$</span> and multiply it by the sum of track probabilities to get "target probability" <span>$$P_{target}$$</span>.
> 3. Iterate over tracks and sum probabilities until <span>$$P_{target}$$</span> is reached - select the last track we iterated over to play.
> 4. Update the probability of the last track we played - in our case we set it to <span>$$0$$</span>.
> 5. Update the probabilities of any other tracks that are less than <span>$$N$$</span> (i.e. ones that have been recently played) - in our case we add <span>$$1$$</span>.
> 6. GOTO 2!

