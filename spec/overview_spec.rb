# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Overview' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Page elements' do
    it '(HAPPY) should see website features' do
      # GIVEN
      @browser.goto homepage
      @browser.title.must_include 'ShareLearning'

      # THEN
      @browser.input(name: 'search_keyword').visible?.must_equal true
    end

    it '(HAPPY) should see content' do
      # GIVEN
      @browser.goto homepage

      # THEN
      @browser.divs(class: 'course_overview').count.must_be :>=, 1
      @browser.divs(class: 'course_overview')[0].text.must_include 'Coursera'
      @browser.divs(class: 'course_overview')[1].text.must_include 'Udacity'
      @browser.divs(class: 'course_overview')[2].text.must_include 'Youtube'
    end

    it '(HAPPY) should see the number of courses for each resource' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # THEN: should see number of courses 
      courses = @browser.divs(class: 'course_overview')
      courses[0].text.must_match /\d/
      courses[1].text.must_match /\d/
      courses[2].text.must_include 'inf'
    end
  end
end