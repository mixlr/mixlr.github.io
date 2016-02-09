---
layout: post
title:  "How to make CSRF protection work with page caching"
date:   2016-01-25 14:00:00
author: Rob
categories: development
excerpt: How can you deliver a high-traffic web application, but still protect the safety of your users? We explore some possible ways to combine protection from CSRF attacks, and page caching.
comments: true
tags: csrf, page caching
---

<p class="info_block"><strong>We're hiring!</strong> Are you a web developer who wants to work on interesting technical challenges with a small, passionate team here in London? We'd love to chat more: drop us a line via <a href="mailto:jobs@mixlr.com">jobs@mixlr.com</a>.</p>

Here at Mixlr we are accustomed to building our service to work well in high-traffic scenarios. We also place a high premium on maintaining our users' security and safety. But what happens when these two essential goals conflict with each other?

One example of this is maintaining [CSRF protection](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf) whilst also benefitting from [page caching](http://guides.rubyonrails.org/caching_with_rails.html#page-caching). Here's how we do it.

#### What is CSRF protection?

CSRF protection allows us to ensure our users do not become the victims of cross-site forgery attacks.

Here's a simple example:

1. You're browsing the internet, while logged into your Mixlr account
2. You inadvertedly visit a malicious or infected website
3. The malicious site uses JavaScript to make a POST request to (for example) mixlr.com/comments - our endpoint for incoming chat messages.

With no CSRF protection, the malicious site only has to figure out the format to POST the data. *No authentication is required, because your browser will helpfully include your mixlr.com session and login cookies with the request!*

With no further user interaction required, the malicious site is hapilly posting one or more chat messages from your Mixlr account. (And doubtless "helping" the rest of our community with the location of dubious mens' health shopping portals and the like.)

CSRF protection typically avoids this by including a hidden, secret value in every form submission. This value - the **form authenticity token** - is checked by the server before any non-GET request is processed. And because the malicious website could not know the value of a given user's secret token, it renders this type of attack completely toothless.

![The form authenticity token seen in the wild](/images/token.png)

#### What is page caching?

Page caching is a powerful way of increasing the scalability of your web service. It works on the premise that serving a static file - that is, a page of pre-rendered HTML markup - is likely to be profoundly faster than using a language like PHP, Ruby or Python to generate the same content.

It turns out that this premise is an entirely valid one - as a rule, cutting out the roundtrip to backend web servers, database, et al allows us to serve many hundreds times more concurrent page views than we'd be able to without page caching.

The limitation with page caching is the obvious one. As we're short-circuiting the backend web servers, it's only good for non-dynamic content - that is, content you're prepared to be served without modification to every user, whether they're logged in or not.

#### Why CSRF protection and page caching clash

Which leads us nicely onto why these two desirable technologies don't work well together.

CSRF protection requires a unique-per-user token to be included in each page. But page caching makes this, at least on the surface, impossible - because dynamic content in each page cannot be achieved.

#### Option 1: Server-side includes

For many years, we've [embedded Lua into the Nginx server](https://www.nginx.com/resources/wiki/modules/lua/) to help us to turbo-charge our deployments.

This also helped us make page caching and CSRF work together. Specifically, we made use of SSI, or [server-side includes](http://nginx.org/en/docs/http/ngx_http_ssi_module.html). These are effectively small templates which are injected by Nginx into every page - even cached ones.

With the help of some custom Lua code, which made a sub-request to a very fast, efficient Rails endpoint when required to fetch a new CSRF token, we were able to serve tens of thousands of cached responses every second - and include a unique CSRF token in each and every one.

While this solution was very clever and flexible, it came with some downsides too. Debugging Lua code at the Nginx level is difficult and counter-intuitive - and just *having* code at the Nginx/Lua level is a bit surprising too! It's not the first place you think of checking when you've got a login/CSRF bug.

Furthermore, as we've incrementally improved our session management and authentication code, we've observed more and more bugs which were traced back to this code. So we went looking for a different approach.

#### Option 2: AJAX

Another option would be to not render a CSRF token in each page, but instead use JavaScript to make a background HTTP request and fetch the CSRF token after the page has loaded.

This would allow us to cache the main content on the page, but then trigger a background request to fetch the CSRF token for the user.

The advantage here is that it allows us to remove the custom Nginx/Lua code, and keep this essential functionality upfront and visible in our codebase. On the downside, there will be a delay after loading the page during which the user will be unable to successfully submit any forms. And if the request to fetch the CSRF token fails for some reason, any such form submissions will fail at least until the page is reloaded.

#### Our current solution

We want to avoid as much code at the Nginx level as possible, so we've made the call to remove our implementation of Option 1.

Additionally, we want to make our lives as easy as possible - so for all non-cached responses (that is - where the page generation is handled by our backend Rails servers) - we're allowing the framework to take the strain. In these cases, we simply allow Rails' [built-in CSRF token helpers](http://api.rubyonrails.org/classes/ActionView/Helpers/CsrfHelper.html) do the work, and render the token in the page for us.

How do we deal with page-cached responses? Firstly, we make sure that we *don't* include the CSRF token when we're caching a page.

<script src="https://gist.github.com/rfwatson/53d20c52475a5d39a2de.js"></script>

And then in our controller, something like:

<script src="https://gist.github.com/rfwatson/2c5468883ebe59fc770a.js"></script>

Now, Nginx will serve page-cached content with the invalid form authenticity token removed.

In our front-end code, we simply check to see if we're missing a CSRF token - that is, if the page we're on has been served from a static file - and if so, make a quick XHR request to pick up the token, populate the forms and set the session cookie.

Job done!

#### What's next?

We'd love to hear your feedback, or suggestions for improvements to our approach. [Drop us a line](http://mixlr.com/help/contact) and let us know what you think!
