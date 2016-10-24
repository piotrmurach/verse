# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Sanitizer, '.replace' do
  subject(:sanitizer) { described_class }

  {
    "  \n"      => '  ',
    "\n  "      => '  ',
    "\n"        => ' ',
    "\n\n\n"    => ' ',
    " \n "      => '  ',
    " \n \n \n" => '   '
  }.each do |string, expected|
    it "replaces '#{string.gsub(/\n/, '\\n')}' with whitespace" do
      expect(sanitizer.replace(string)).to eq(expected)
    end
  end

  {
    "  \r\n" => '  ',
    "\r\n  " => '  ',
    "\r\n"   => ' ',
    " \r\n " => '  ',
  }.each do |string, expected|
    it "replaces '#{string.gsub(/\r\n/, '\\r\\n')}' with whitespace" do
      expect(sanitizer.replace(string, "\r\n")).to eq(expected)
    end
  end
end
