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
      @text = text
      @fill = options.fetch(:fill) { SPACE }
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
      process_lines { |line| line.send(method, width, filler) }
    end

    protected

    # @api private
    def convert_to_method(direction)
      case direction.to_sym
      when :left   then :ljust
      when :right  then :rjust
      when :center then :center
      else
        fail ArgumentError, "Unknown alignment `#{direction}`."
      end
    end

    # @api private
    def process_lines
      lines = text.split(NEWLINE)
      lines.reduce([]) do |aligned, line|
        aligned << yield(line.strip)
      end.join("\n")
    end

    attr_reader :text
  end # Alignment
end # Verse
