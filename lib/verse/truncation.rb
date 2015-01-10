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
      new(text).truncate(truncate_at, options)
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

      chars = @sanitizer.sanitize(text).chars.to_a
      return chars.join if chars.length <= truncate_at
      length_without_trailing = truncate_at - trail.chars.to_a.size
      stop = chars[0, length_without_trailing].rindex(separation)

      chars[0, stop || length_without_trailing].join + trail
    end

    private

    attr_reader :text
  end # Truncation
end # Verse
