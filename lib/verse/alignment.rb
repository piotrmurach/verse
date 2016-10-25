# coding: utf-8

module Verse
  # A class responsible for text alignment
  class Alignment
    attr_reader :fill

    attr_reader :direction

    # Initialize an Alignment
    #
    # @api public
    def initialize(text, options = {})
      @text      = text
      @fill      = options.fetch(:fill) { SPACE }
      @direction = options.fetch(:direction) { :left }
    end

    # Aligns text to the left
    #
    # @return [String]
    #
    # @api public
    def left(width, options = {})
      align(width, :left, options)
    end

    # Centers text within the width
    #
    # @return [String]
    #
    # @api public
    def center(width, options = {})
      align(width, :center, options)
    end

    # Aligns text to the right
    #
    # @return [String]
    #
    # @api public
    def right(width, options = {})
      align(width, :right, options)
    end

    # Align a text to a given direction with the width
    #
    # @see Verse::Alignment#align
    #
    # @api public
    def self.align(text, width, direction, options)
      new(text, options).align(width, direction, options)
    end

    # Aligns text within the width.
    #
    # If the text is greater than the width then unmodified
    # string is returned.
    #
    # @example
    #   alignment = Verse::Alignment.new "the madness of men"
    #
    #   alignment.align(22, :left)
    #   # => "the madness of men      "
    #
    #   alignment.align(22, :center)
    #   # => "   the madness of men   "
    #
    #   alignment.align(22, :right)
    #   # => "      the madness of men"
    #
    # @api public
    def align(width, direction = :left, options = {})
      return text unless width

      filler = options.fetch(:fill) { fill }
      method = convert_to_method(direction)
      process_lines { |line| send(method, line, width, filler) }
    end

    protected

    # The text to align
    #
    # @ api private
    attr_reader :text

    # @api private
    def convert_to_method(direction)
      case direction.to_sym
      when :left   then :left_justify
      when :right  then :right_justify
      when :center then :center_justify
      else
        raise ArgumentError, "Unknown alignment `#{direction}`."
      end
    end

    # @api private
    def process_lines
      lines = text.split(NEWLINE)
      return yield(text) if text.empty?
      lines.reduce([]) do |aligned, line|
        aligned << yield(line)
      end.join("\n")
    end

    # @api private
    def left_justify(text, width, filler)
      width_diff = width - display_width(text)
      if width_diff > 0
        text + filler * width_diff
      else
        text
      end
    end

    # @api private
    def right_justify(text, width, filler)
      width_diff = width - display_width(text)
      if width_diff > 0
        filler * width_diff + text
      else
        text
      end
    end

    # @api private
    def center_justify(text, width, filler)
      text_width = display_width(text)
      width_diff = width - text_width
      if width_diff > 0
        right_count = (width_diff.to_f / 2).ceil
        left_count  =  width_diff - right_count
        [filler * left_count, text, filler * right_count].join
      else
        text
      end
    end

    # @api private
    def display_width(text)
      Unicode::DisplayWidth.of(Sanitizer.sanitize(text))
    end
  end # Alignment
end # Verse
