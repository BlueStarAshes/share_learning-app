# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'

NEW_KEYWORD = 'java'

HOST = 'http://localhost:9000'

# Helper methods
def search_page(keyword)
  "#{HOST}/search?search_keyword=#{keyword}"
end