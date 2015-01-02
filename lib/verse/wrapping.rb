# coding: utf-8

module Verse
  # A class responsible for text wrapping
  class Wrapping
    DEFAULT_WIDTH = 80.freeze

    attr_reader :indent

    attr_reader :padding

    # Initialize a Wrapping
    #
    # @param [String] text
    #   the text to be wrapped
    #
    # @param [Hash] options
    #   @option options [Symbol] :indent the indentation
    #   @option options [Symbol] :padding the desired spacing
    #
    # @api public
    def initialize(text, options = {})
      @text    = text
      @indent  = options.fetch(:indent) { 0 }
      @padding = options.fetch(:padding) { [] }
      @sanitizer = Sanitizer.new
    end

    # Wrap a text into lines no longer than length
    #
    # @example
    #   wrapping = Verse::Wrapping.new "Some longish text"
    #
    #   wrapping.wrap(8)
    #   # => "Some\nlongish\ntext"
    #
    #   wrapping.wrap(8, indent: 4)
    #   # => >    Some
    #        >    longish
    #        >    text
    #
    # @api public
    def wrap(wrap_at = DEFAULT_WIDTH, options = {})
      if text.length < wrap_at.to_i || wrap_at.to_i.zero?
        return text.dup
      end

      indentation = options.fetch(:indent) { indent }
      spacing     = options.fetch(:padding) { padding }

      text.split(NEWLINE, -1).map do |line|
        pad_line(indent_line(wrap_line(line, wrap_at), indentation), spacing)
      end * NEWLINE
    end

    private

    # Calculate string length without color escapes
    #
    # @param [String] string
    #
    # @api private
    def actual_length(string, at)
      at + (string.length - @sanitizer.sanitize(string).length)
    end

    # Wrap line at given length
    #
    # @param [String] line
    #
    # @return [String]
    #
    # @api private
    def wrap_line(line, at)
      wrap_at = actual_length(line, at)
      line.strip.gsub(/\n/, ' ').squeeze(' ')
        .gsub(/(.{1,#{wrap_at}})(?:\s+|$\n?)|(.{1,#{wrap_at}})/, "\\1\\2\n")
        .strip
    end

    # Indent string by given value
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api private
    def indent_line(text, indent)
      text.split(NEWLINE).each do |line|
        line.insert(0, SPACE * indent)
      end
    end

    # Add padding to each line in wrapped text
    #
    # @param [String] text
    #   the wrapped text
    #
    # @return [String]
    #
    # @api private
    def pad_line(text, padding)
      return text if text.empty? || padding.empty?

      padding_left  = SPACE * padding[3].to_i
      padding_right = SPACE * padding[1].to_i
      text.map! do |part|
        part.insert(0, padding_left).insert(-1, padding_right)
      end
    end

    attr_reader :text
  end # Wrapping
end # Verse
