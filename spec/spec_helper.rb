# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'
require_relative 'pages/init.rb'

NEW_KEYWORD = 'java'
BAD_KEYWORD = 'ThisIsBadKeyword'

HOST = 'http://localhost:9000'

# Helper methods
def homepage
  HOST
end
