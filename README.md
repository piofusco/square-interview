# Block iOS Take Home Interview

## Build tools & versions used

This project is built with Xcode 13.2.1 with Swift.

## Steps to run the app

To run the app, select the Contacts target, pick a simulator, and run.
To run the tests, select the ContactsTests, and run.

## What areas of the app did you focus on?

Two things: tests and K.I.S.S (not the band).

## What was the reason for your focus? What problems were you trying to solve?

In my experience, testing is usually an afterthought. With greenfield work, TDD shines. As practitioner of TDD, my 
biggest focus is always driving all functionality with tests - rather than back filling once everything is done. This 
helps me limit the focus of whatever I am working on so that I don't over implement/engineer. I hope the tests provided 
give you a good idea of how things work without looking at the implementation.

My second focus was simplicity. As such, I opted to use MVVM as I find this one of the most flexible patterns for
testing. I have experience with VIPER, but 9 times out 10 it is completely unnecessary. Given the small scope of this
project, it helped simplify what order I drove out my tests and what features I worked on next.

## How long did you spend on this project?

I spent a little over 5 hours over the course of two days.

## Did you make any trade-offs for this project? What would you have done differently with more time?

One trade-off I made with this project was to use Kingfisher for image caching. While it's a well maintained open 
source project, if I had more time I would have liked to write my own image caching solution (maybe using URLCache or 
NSCache).

Third party libraries are great for limited features like image caching. However, every library requires 
some attention to detail - developers need to pay attention to the latest version to ensure none of the updates break 
their application. For my purposes, I was comfortable with the ease of use and functionality Kingfisher afforded me 
on disk image caching.

Took me 10 minutes to implement image cache - implementing it myself might have taken me longer.

## What do you think is the weakest part of your project?

While there's plenty of unit tests that tell me my components work, there's no tests to tell me my code accomplishes 
what is required. Over the years, I have become very comfortable implementing higher order tests using a combination of 
a mock server (Sinatra.rb) run locally + UI testing framework. Having a test pass/fail and tell me the app does what is 
described would help close the gap. This unfortunately well out-of-scope given the timeframe.

## Did you copy any code or dependencies? Please make sure to attribute them here!

As mentioned, I use Kingfisher for image caching. That's it for third party libraries.

Additionally, a lot of the networking and wrappers around Foundation classes I had written previously.

## Is there any other information you’d like us to know?

I opted not to use SwiftUI as I prefer programmatic UIKit.