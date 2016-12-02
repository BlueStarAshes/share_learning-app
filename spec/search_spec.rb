# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Search Page' do
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

  it '(HAPPY) should see website features' do
    # GIVEN    
    @browser.goto search_page('machine+learning')
    @browser.title.must_include 'ShareLearning'
    @browser.h1.text.must_include 'ShareLearning'

    # THEN
    @browser.button(name: 'btn-search').visible?.must_equal true
    @browser.input(name: 'search_keyword').visible?.must_equal true
    @browser.p(class: "results_count").visible?.must_equal true
    @browser.table(id: "course_table").visible?.must_equal true
  end

  it '(HAPPY) should see content' do
    # GIVEN    
    @browser.goto search_page('machine+learning')

    # THEN
    @browser.trs(class: 'course_row').count.must_be :>=, 1
    first_row = @browser.trs(class: 'course_row').first
    first_row.img(class: 'course_photo').visible?.must_equal true
    first_row.p(class: 'summary').visible?.must_equal true
    first_row.input(class: 'btn-info').visible?.must_equal true
  end  

  it '(HAPPY) should input a new keyword to search courses' do
    # GIVEN: on the homepage
    @browser.goto search_page('machine+learning')

    # WHEN: add a valid group url
    @browser.text_field(name: 'search_keyword').set(NEW_KEYWORD)
    @browser.button(name: "btn-search").click

    # THEN: group should be present on homepage
    @browser.trs(class: 'course_row').count.must_be :>=, 1
    first_row = @browser.trs(class: 'course_row').first
    first_row.img(class: 'course_photo').visible?.must_equal true
    first_row.p(class: 'summary').visible?.must_equal true
    first_row.input(class: 'btn-info').visible?.must_equal true
  end  

  it '(SAD) should alert if user did not input any keyword for search' do
    # GIVEN: on the homepage
    @browser.goto search_page('machine+learning')

    # WHEN: add an existing group url
    @browser.button(name: "btn-search").click

    # THEN: danger flash notice should be seen
    flash_notice = @browser.div(class: 'alert')
    flash_notice.attribute_value('class').must_include 'danger'
  end  
end