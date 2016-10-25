# coding: utf-8

require 'unicode/display_width'
require 'unicode_utils/each_grapheme'

require 'verse/alignment'
require 'verse/padder'
require 'verse/padding'
require 'verse/sanitizer'
require 'verse/truncation'
require 'verse/wrapping'
require 'verse/version'

module Verse
  SPACE   = ' '.freeze
  NEWLINE = "\n".freeze
  RESET   = "\e[0m".freeze
  ANSI    = "\033".freeze

  SPACE_RE   = %r{\s+}mo.freeze
  NEWLINE_RE = %r{\n}o.freeze

  # Align a text to a given direction with the width
  #
  # @see Verse::Alignment#align
  #
  # @api public
  def self.align(text, width, direction, options = {})
    Alignment.align(text, width, direction, options)
  end

  # Pad a text around with a given padding
  #
  # @see Verse::Padding#pad
  #
  # @api public
  def self.pad(text, padding, options = {})
    Padding.pad(text, padding, options)
  end

  # Truncate a text at a given length
  #
  # @see Verse::Truncation#truncate
  #
  # @api public
  def self.truncate(text, truncate_at, options = {})
    Truncation.truncate(text, truncate_at, options)
  end

  # Wrap a text into lines at wrap length
  #
  # @see Verse::Wrapping#wrap
  #
  # @api public
  def self.wrap(text, wrap_at, options = {})
    Wrapping.wrap(text, wrap_at, options)
  end
end # Verse
