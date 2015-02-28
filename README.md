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
* Simple API that can be easily wrapped by other objects
* Supports multibyte character encodings such as UTF-8, EUC-JP
* Handles languages without whitespaces between words (like Chinese and Japanese)

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

## Contents

* [1. Usage](#1-usage)
  * [1.1 Align](#11-align)
  * [1.2 Replace](#12-replace)
  * [1.3 Truncate](#13-truncate)
  * [1.4 Wrap](#14-wrap)

## 1 Usage

### 1.1 Align

**Verse::Alignment** allows you to align text within a given length:

```ruby
alignment = Verse::Alignment.new "for there is no folly of the beast\n" +
                                 " of the earth which\n" +
                                 " is not infinitely\n" +
                                 " outdone by the madness of men"
```

Then using direction out of `:right`, `:left` or `:center` methods and passing width you can align the text:

```ruby
alignemnt.align(40, :right) # =>
    "      for there is no folly of the beast\n" +
    "                      of the earth which\n" +
    "                       is not infinitely\n" +
    "           outdone by the madness of men"
```

Aligning `UTF-8` text is also supported:

```ruby
alignment = Verse::Alignment.new "ラドクリフ\n" +
                                 "、マラソン五輪\n" +
                                 "代表に1万m出\n" +
                                 "場にも含み"

alignment.center(20) # =>
    "     ラドクリフ     \n" +
    "   、マラソン五輪   \n" +
    "    代表に1万m出    \n" +
    "     場にも含み     "
```

### 1.2 Replace

**Verse::Sanitizer** provides ability to sanitize text with unwanted characters. Given a text with line break characters, `replace` will remove or substitute all occurances of line breaks depending on surrounding context.

```ruby
sanitizer = Verse::Sanitizer.new
sanitizer.replace("It is not down on any map;\r\n true places never are.")
# => "It is not down on any map; true places never are."
```

### 1.3 Truncate

Using **Verse::Truncation** you can truncate a given text after a given length.

```ruby
truncation = Verse::Truncation.new "for there is no folly of the beast of the earth " +
                                   "which is not infinitely outdone by the madness of men"

```

Then to shorten the text to given length call `truncate`:

```ruby
truncation.truncate(20) # => "for there is no fol…"
```

Pass in `:trailing` (by default `…`) to replace last characters:

```ruby
truncation.truncate(22, trailing: '... (see more)')
# => "for there...(see more)"
```

You can also specify `UTF-8` text as well:

```ruby
truncation = Verse::Truncation.new 'ラドクリフ、マラソン五輪代表に1万m出場にも含み'
truncation.truncate(12)   # => "ラドクリフ…"
```

### 1.4 Wrap

**Verse::Wrapping** allows you to wrap text into lines no longer than `wrap_at` argument length. The `wrap` method will break either on whitespace character or in case of east Asian characters on character boundaries.

```ruby
wrapping = Verse::Wrapping.new "Think not, is my eleventh commandment; " +
                               "and sleep when you can, is my twelfth."

```

Then to wrap the text to given length do:

```ruby
wrapping.wrap(30) # =>
  "Think not, is my eleventh"
  "commandment; and sleep when"
  "you can, is my twelfth."
```

Similarly, to handle `UTF-8` text do:

```ruby
wrapping = Verse::Wrapping.new "ラドクリフ、マラソン五輪代表に1万m出場にも含み"
wrapping.wrap(8)  # =>
  "ラドクリ"
  "フ、マラ"
  "ソン五輪"
  "代表に1"
  "万m出場"
  "にも含み"
```

You can also call `wrap` directly on **Verse**:

```ruby
Verse.wrap(text, wrap_at)
```

## Contributing

1. Fork it ( https://github.com/peter-murach/verse/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2015 Piotr Murach. See LICENSE for further details.
