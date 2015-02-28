# coding: utf-8

module Verse
  # A class responsible for text wrapping
  class Wrapping
    DEFAULT_WIDTH = 80.freeze

    # Initialize a Wrapping
    #
    # @param [String] text
    #   the text to be wrapped
    #
    # @param [Hash] options
    #   @option options [Symbol] :padding the desired spacing
    #
    # @api public
    def initialize(text, options = {})
      @text    = text
      @line_width = options.fetch(:line_width) { DEFAULT_WIDTH }
      @sanitizer = Sanitizer.new
    end

    # Wrap a text into lines no longer than wrap_at
    #
    # @api public
    def self.wrap(text, wrap_at, options = {})
      new(text, options).wrap(wrap_at)
    end

    # Wrap a text into lines no longer than wrap_at length.
    # Preserves existing lines and existing word boundaries.
    #
    # @example
    #   wrapping = Verse::Wrapping.new "Some longish text"
    #
    #   wrapping.wrap(8)
    #   # => >Some
    #        >longish
    #        >text
    #
    # @api public
    def wrap(wrap_at = DEFAULT_WIDTH)
      if text.length < wrap_at.to_i || wrap_at.to_i.zero?
        return text
      end
      text.split(NEWLINE, -1).map do |paragraph|
        format_paragraph(paragraph, wrap_at)
      end * NEWLINE
    end

    # Format paragraph to be maximum of wrap_at length
    #
    # @param [String] paragraph
    #   the paragraph to format
    # @param [Integer] wrap_at
    #   the maximum length to wrap the paragraph
    #
    # @return [Array[String]]
    #   the wrapped lines
    #
    # @api private
    def format_paragraph(paragraph, wrap_at)
      cleared_para = @sanitizer.replace(paragraph)
      lines = []
      line = ''
      word  = ''
      word_length = 0
      line_length = 0
      char_length = 0 # visible char length
      text_length = display_width(cleared_para)
      total_length = 0
      UnicodeUtils.each_grapheme(cleared_para) do |char|
        char_length = display_width(char)
        total_length += char_length
        if line_length + word_length + char_length <= wrap_at
          if char == SPACE || total_length == text_length
            line << word + char
            line_length += word_length + char_length
            word = ''
            word_length = 0
          else
            word << char
            word_length += char_length
          end
          next
        end

        if char == SPACE # ends with space
          lines << line
          line = ''
          line_length = 0
          word = word + char
          word_length = word_length + char_length
        elsif word_length + char_length <= wrap_at
          lines << line
          line = word + char
          line_length = word_length + char_length
          word = ''
          word_length = 0
        else # hyphenate word - too long to fit a line
          lines << word
          line_length = 0
          word = char
          word_length = char_length
        end
      end
      lines << line unless line.empty?
      lines << word unless word.empty?
      lines
    end

    protected

    # The text to wrap
    #
    # @api private
    attr_reader :text

    # Visible width of string
    #
    # @api private
    def display_width(string)
      UnicodeUtils.display_width(string)
    end
  end # Wrapping
end # Verse
