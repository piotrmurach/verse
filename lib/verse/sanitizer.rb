# coding: utf-8

module Verse
  class Sanitizer
    ANSI_MATCHER = /(\[)?\033(\[)?[;?\d]*[\dA-Za-z](\])?/.freeze

    # Strip ANSI characters from the text
    #
    # @param [String] text
    #
    # @return [String]
    #
    # @api private
    def sanitize(text)
      text.gsub(ANSI_MATCHER, '')
    end
  end # Sanitizer
end # Verse
