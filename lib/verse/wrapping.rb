# coding: utf-8

module Verse
  # A class responsible for text wrapping
  class Wrapping
    DEFAULT_WIDTH = 80

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
      @text       = text
      @line_width = options.fetch(:line_width) { DEFAULT_WIDTH }
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
      ansi_stack = []
      text.split(NEWLINE, -1).map do |paragraph|
        format_paragraph(paragraph, wrap_at, ansi_stack)
      end * NEWLINE
    end

    protected

    # The text to wrap
    #
    # @api private
    attr_reader :text

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
    def format_paragraph(paragraph, wrap_at, ansi_stack)
      cleared_para = Sanitizer.replace(paragraph)
      lines = []
      line = ''
      word = ''
      word_length = 0
      line_length = 0
      char_length = 0 # visible char length
      text_length = display_width(cleared_para)
      total_length = 0
      ansi = ''
      matched = nil
      to_chars(cleared_para) do |char|
        if char == ANSI # found ansi
          ansi << char && next
        end

        if ansi.length > 0
          ansi << char
          if Sanitizer.ansi?(ansi) # we found ansi let's consume
            matched = ansi
          elsif matched
            ansi_stack << [matched[0...-1], line_length + word_length]
            matched = nil
            ansi    = ''
          end
          next if ansi.length > 0
        end

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
          lines << insert_ansi(ansi_stack, line)
          line = ''
          line_length = 0
          word += char
          word_length += char_length
        elsif word_length + char_length <= wrap_at
          lines << insert_ansi(ansi_stack, line)
          line = word + char
          line_length = word_length + char_length
          word = ''
          word_length = 0
        else # hyphenate word - too long to fit a line
          lines << insert_ansi(ansi_stack, word)
          line_length = 0
          word = char
          word_length = char_length
        end
      end
      lines << insert_ansi(ansi_stack, line) unless line.empty?
      lines << insert_ansi(ansi_stack, word) unless word.empty?
      lines
    end

    # Insert ANSI code into string
    #
    # Check if there are any ANSI states, if present
    # insert ANSI codes at given positions unwinding the stack.
    #
    # @param [Array[Array[String, Integer]]] ansi_stack
    #   the ANSI codes to apply
    #
    # @param [String] string
    #   the string to insert ANSI codes into
    #
    # @return [String]
    #
    # @api private
    def insert_ansi(ansi_stack, string)
      return string if ansi_stack.empty?
      to_remove = 0
      reset_index = -1
      output = string.dup
      resetting = false
      ansi_stack.reverse_each do |state|
        if state[0] =~ /#{Regexp.quote(RESET)}/
          resetting = true
          reset_index = state[1]
          to_remove += 2
          next
        elsif !resetting
          reset_index = -1
          resetting = false
        end

        color, color_index = *state
        output.insert(reset_index, RESET).insert(color_index, color)
      end
      ansi_stack.pop(to_remove) # remove used states
      output
    end

    # @api private
    def to_chars(text, &block)
      if block_given?
        UnicodeUtils.each_grapheme(text, &block)
      else
        UnicodeUtils.each_grapheme(text)
      end
    end

    # Visible width of string
    #
    # @api private
    def display_width(string)
      Unicode::DisplayWidth.of(Sanitizer.sanitize(string))
    end
  end # Wrapping
end # Verse
