# coding: utf-8

module Verse
  # A class responsible for text truncation operations
  class Truncation
    DEFAULT_TRAILING = '…'.freeze

    DEFAULT_LENGTH = 30

    attr_reader :separator

    attr_reader :trailing

    # Initialize a Truncation
    #
    # @param [String] text
    #   the text to be truncated
    #
    # @param [Hash] options
    #   @option options [Symbol] :separator the character for splitting words
    #   @option options [Symbol] :trailing  the character for ending sentence
    #
    # @api public
    def initialize(text, options = {})
      @text      = text.dup.freeze
      @separator = options.fetch(:separator) { nil }
      @trailing  = options.fetch(:trailing) { DEFAULT_TRAILING }
    end

    # Truncate a text at a given length
    #
    # @see Verse::Truncation#truncate
    #
    # @api public
    def self.truncate(text, truncate_at, options = {})
      new(text, options).truncate(truncate_at, options)
    end

    # Truncate a text at a given length (defualts to 30)
    #
    # @example
    #   truncation = Verse::Truncation.new
    #     "The sovereignest thing on earth is parmacetti for an inward bruise."
    #
    #   truncation.truncate
    #   # => "The sovereignest thing on ear…"
    #
    #   truncate(20)
    #   # => "The sovereignest th…"
    #
    #   truncate(20, separator: ' ' )
    #   # => "The sovereignest…"
    #
    #   truncate(40, trailing: '... (see more)' )
    #   # => "The sovereignest thing on... (see more)"
    #
    # @api public
    def truncate(truncate_at = DEFAULT_LENGTH, options = {})
      if display_width(text) <= truncate_at.to_i || truncate_at.to_i.zero?
        return text.dup
      end
      trail      = options.fetch(:trailing) { trailing }
      separation = options.fetch(:separator) { separator }
      width      = display_width(text)
      sanitized_text = Sanitizer.sanitize(text)

      return text if width <= truncate_at

      length_without_trailing = truncate_at - display_width(trail)
      chars = to_chars(sanitized_text).to_a
      stop  = chars[0, length_without_trailing].rindex(separation)
      slice_length = stop || length_without_trailing
      sliced_chars = chars[0, slice_length]
      original_chars = to_chars(text).to_a[0, 3 * slice_length]
      shorten(original_chars, sliced_chars, length_without_trailing).join + trail
    end

    protected

    attr_reader :text

    # Perform actual shortening of the text
    #
    # @return [String]
    #
    # @api private
    def shorten(original_chars, chars, length_without_trailing)
      truncated = []
      char_width = display_width(chars[0])
      while length_without_trailing - char_width > 0
        orig_char = original_chars.shift
        char = chars.shift
        break unless char
        while orig_char != char # consume ansi
          ansi = true
          truncated << orig_char
          orig_char = original_chars.shift
        end
        truncated << char
        char_width = display_width(char)
        length_without_trailing -= char_width
      end
      truncated << ["\e[0m"] if ansi
      truncated
    end

    # @api private
    def to_chars(text)
      UnicodeUtils.each_grapheme(text)
    end

    # @api private
    def display_width(string)
      Unicode::DisplayWidth.of(Sanitizer.sanitize(string))
    end
  end # Truncation
end # Verse
