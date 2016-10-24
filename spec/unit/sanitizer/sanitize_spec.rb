# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Sanitizer, '.sanitize' do
  subject(:sanitizer) { described_class }

  {
    "\e[20h" => '',
    "\e[?1h" => '',
    "\e[20l" => '',
    "\e[?9l" => '',
    "\eO"    => '',
    "\e[m"   => '',
    "\e[0m"  => '',
    "\eA"    => '',
    "\e[0;33;49;3;9;4m\e[0m" => ''
  }.each do |code, expected|
    it "strips #{code} from string" do
      expect(sanitizer.sanitize(code)).to eq(expected)
    end
  end
end
