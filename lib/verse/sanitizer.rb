# coding: utf-8

module Verse
  class Sanitizer
    ANSI_MATCHER = /(\[)?\033(\[)?[;?\d]*[\dA-Za-z](\])?/.freeze

    LINE_BREAK = "(\r\n+|\r+|\n+|\t+)".freeze

    # Strip ANSI characters from the text
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api public
    def sanitize(text)
      text.gsub(ANSI_MATCHER, '')
    end

    # Replace separator with whitespace
    #
    # @example
    #   replace(" \n ") # => "  "
    #   replace("\n")   # => " "
    #
    # @param [String] text
    #
    # @param [String] separator
    #
    # @return [String]
    #
    # @api public
    def replace(text, separator = LINE_BREAK)
      text.gsub(/([ ]+)#{separator}/, "\\1").
           gsub(/#{separator}(?<space>[ ]+)/, "\\k<space>").
           gsub(/#{separator}/, ' ')
    end
  end # Sanitizer
end # Verse
