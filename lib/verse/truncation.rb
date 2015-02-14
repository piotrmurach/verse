# coding: utf-8

module Verse
  # A class responsible for text truncation operations
  class Truncation
    DEFAULT_TRAILING = '…'.freeze

    DEFAULT_LENGTH = 30.freeze

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
      @text      = text
      @sanitizer = Sanitizer.new
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
      if text.length <= truncate_at.to_i || truncate_at.to_i.zero?
        return text.dup
      end
      trail = options.fetch(:trailing) { trailing }
      separation = options.fetch(:separator) { separator }

      sanitized_text = @sanitizer.sanitize(text)
      width = display_width(sanitized_text)
      chars = Unicode.text_elements(sanitized_text)
      return chars.join if width <= truncate_at
      length_without_trailing = truncate_at - display_width(trail)
      stop = chars[0, length_without_trailing].rindex(separation)
      sliced_chars = chars[0, stop || length_without_trailing]
      shorten(sliced_chars, length_without_trailing).join + trail
    end

    protected

    attr_reader :text

    # Perform actual shortening of the text
    #
    # @return [String]
    #
    # @api private
    def shorten(chars, length_without_trailing)
      truncated = []
      char_width = display_width(chars[0])
      while length_without_trailing - char_width > 0
        char = chars.shift
        break unless char
        truncated << char
        char_width = display_width(char)
        length_without_trailing -= char_width
      end
      truncated
    end

    # @api private
    def display_width(string)
      Unicode.width(string)
    end
  end # Truncation
end # Verse
