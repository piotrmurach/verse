# coding: utf-8

module Verse
  # A class responsible for text indentation
  class Padding
    # Initialize a Padding
    #
    # @api public
    def initialize(text, options = {})
      @text      = text
      @padding   = Padder.parse(options[:padding])
    end

    # Pad content out
    #
    # @see Verse::Padding#pad
    #
    # @api public
    def self.pad(text, padding, options)
      new(text, options).pad(padding, options)
    end

    # Apply padding to text
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api private
    def pad(padding = (not_set = true), options = {})
      return text if @padding.empty? && not_set
      if !not_set
        @padding = Padder.parse(padding)
      end
      text_copy = text.dup
      column_width = maximum_length(text)
      elements = []
      if @padding.top > 0
        elements << (SPACE * column_width + NEWLINE) * @padding.top
      end
      elements << text_copy
      if @padding.bottom > 0
        elements << (SPACE * column_width + NEWLINE) * @padding.bottom
      end
      elements.map { |el| pad_multi_line(el) }.join(NEWLINE)
    end

    protected

    # The text to pad
    #
    # @api private
    attr_reader :text

    # Apply padding to multi line text
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api private
    def pad_multi_line(text)
      text.split(NEWLINE).map { |part| pad_around(part) }
    end

    # Apply padding to left and right side of string
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api private
    def pad_around(text)
      text.insert(0, SPACE * @padding.left).
           insert(-1, SPACE * @padding.right)
    end

    # Determine maximum length for all multiline content
    #
    # @params [String] text
    #
    # @return [Integer]
    #
    # @api private
    def maximum_length(text)
      lines = text.split(/\n/, -1)
      display_width(lines.max_by { |line| display_width(line) } || '')
    end

    def display_width(string)
      Unicode::DisplayWidth.of(Sanitizer.sanitize(string))
    end
  end # Padding
end # Verse
