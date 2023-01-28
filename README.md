# Ruby Challenges / Analyzing Shakespeare

Hey there! We're [thoughtbot](https://thoughtbot.com), a design and
development consultancy that brings your digital product ideas to life.
We also love to share what we learn.

This coding exercise comes from [Upcase](https://thoughtbot.com/upcase),
the online learning platform we run. It's part of the
[Ruby Challenges](https://thoughtbot.com/upcase/ruby-challenges) course and is just one small sample of all
the great material available on Upcase, so be sure to visit and check out the rest.

## Exercise Intro

Difficulty: **Easy, but requires isolating an external service during testing.**

As a Shakespeare buff, statistics junkie, and Unix lover, Ben finds himself wanting a command-line tool for analyzing Macbeth.

Write a command-line program that prints the number of lines spoken by each character in the play.

## Instructions

To start, you'll want to clone and run the setup script for the repo

    git clone git@github.com:thoughtbot-upcase-exercises/analyzing-shakespeare.git
    cd analyzing-shakespeare
    bin/setup

Sample usage/output (using made-up numbers):

    $ ruby macbeth_analyzer.rb
      543 Macbeth
      345 Banquo
      220 Duncan
      (etc.)

You can find an XML-encoded version of Macbeth here: http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml. Your program should download and parse this file at runtime.

Your solution must be tested, preferably via TDD. Running your tests _should not_ download the play from the ibiblio.org server.

Note: some lines are attributed to a speaker called "ALL". Your program should ignore these.

## Featured Solution

Check out the [featured solution branch](https://github.com/thoughtbot-upcase-exercises/analyzing-shakespeare/compare/featured-solution#toc) to
see the approach we recommend for this exercise.

## Forum Discussion

If you find yourself stuck, be sure to check out the associated
[Upcase Forum discussion](https://forum.upcase.com/t/ruby-challenges-analyzing-shakespeare/4604)
for this exercise to see what other folks have said.

## Next Steps

When you've finished the exercise, head on back to the
[Ruby Challenges](https://thoughtbot.com/upcase/ruby-challenges) course to find the next exercise,
or explore any of the other great content on
[Upcase](https://thoughtbot.com/upcase).

## License

analyzing-shakespeare is Copyright © 2015-2018 thoughtbot, inc. It is free software,
and may be redistributed under the terms specified in the
[LICENSE](/LICENSE.md) file.

## Credits

![thoughtbot](https://thoughtbot.com/thoughtbot-logo-for-readmes.svg)

This exercise is maintained and funded by
[thoughtbot, inc](http://thoughtbot.com/community).

The names and logos for Upcase and thoughtbot are registered trademarks of
thoughtbot, inc.
