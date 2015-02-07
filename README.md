# Verse
[![Gem Version](https://badge.fury.io/rb/verse.png)][gem]
[![Build Status](https://secure.travis-ci.org/peter-murach/verse.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/peter-murach/verse.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/peter-murach/verse/badge.png)][coverage]
[![Inline docs](http://inch-ci.org/github/peter-murach/verse.png)][inchpages]

[gem]: http://badge.fury.io/rb/verse
[travis]: http://travis-ci.org/peter-murach/verse
[codeclimate]: https://codeclimate.com/github/peter-murach/verse
[coverage]: https://coveralls.io/r/peter-murach/verse
[inchpages]: http://inch-ci.org/github/peter-murach/verse

> Text transformations such as truncation, wrapping, aligning, indentation and grouping of words.

## Features

* No monkey-patching String class

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'verse'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install verse
```

## 1 Usage

### 1.1 align

**Verse** allows you to align text:

```ruby
alignment = Verse::Alignment.new "for there is no folly of the beast\n" +
                                 " of the earth which\n" +
                                 " is not infinitely\n" +
                                 " outdone by the madness of men"
```

Then using `right`, `left` or `center` methods and passing width you can align the text:

```ruby
alignemnt.right(40) # =>
    "      for there is no folly of the beast\n" +
    "                      of the earth which\n" +
    "                       is not infinitely\n" +
    "           outdone by the madness of men"
```

### 1.2 truncate

Using **Verse** you can truncate a given text:

```ruby
truncation = Verse::Truncation.new "for there is no folly of the beast of the earth " +
                                   "which is not infinitely outdone by the madness of men"

```

Then to shorten the text to given length call `truncate`:

```ruby
truncation.truncate(20) # => "for there is no fol…"
```

### 1.3 wrap

```ruby
wrapping = Verse::Wrapping.new "Think not, is my eleventh commandment; " +
                               "and sleep when you can, is my twelfth."

```

Then to wrap the text to given length call `wrap`:

```ruby
wrapping.wrap(30)
# => "Think not, is my eleventh"
     "commandment; and sleep when"
     "you can, is my twelfth."
```

## Contributing

1. Fork it ( https://github.com/peter-murach/verse/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2015 Piotr Murach. See LICENSE for further details.
