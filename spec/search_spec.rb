# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
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
    include PageObject::PageFactory

    it '(HAPPY) should see website features' do
      # GIVEN: user goes to the search page
      visit SearchPage do |page|
        # THEN
        page.title.must_include 'ShareLearning'
        page.heading.must_include 'ShareLearning' 
        page.search_btn_element.visible?.must_equal true
        page.keyword_input_element.visible?.must_equal true
        page.counts_element.visible?.must_equal true
        page.courses_table_element.visible?.must_equal true
      end
    end

    it '(HAPPY) should see content' do
      # GIVEN: user goes to the search page
      visit SearchPage do |page|
        # THEN: user should see a row with course information
        page.courses_count.must_be :>=, 1
        page.first_row.img_element.visible?.must_equal true
        page.first_row.title_element.visible?.must_equal true
        page.first_row.intro_element.visible?.must_equal true
        page.first_row.link_element.visible?.must_equal true
      end
    end
  end

  describe 'Search courses with keyword' do
    include PageObject::PageFactory

    it '(HAPPY) should search course with new keyword successfully' do
      # GIVEN: user goes to the search page
      visit SearchPage do |page|
        # WHEN: input an bad keyword
        page.input_keyword(NEW_KEYWORD)

        # THEN: user should see a row with course information
        page.courses_count.must_be :>=, 1
        page.first_row.img_element.visible?.must_equal true
        page.first_row.title_element.visible?.must_equal true
        page.first_row.intro_element.visible?.must_equal true
        page.first_row.link_element.visible?.must_equal true
      end
    end

    it '(SAD) should alert if user did not input any keyword for search' do
      # GIVEN: user goes to the search page
      visit SearchPage do |page|
        # WHEN: click the go button
        page.search_btn

        # THEN: danger flash notice should be seen
        page.flash_notice.must_include 'enter'
        page.flash_notice_element.attribute(:class).must_include 'danger'
      end
    end

    it '(SAD) should alert if not found any course' do
      # GIVEN: user goes to the search page
      visit SearchPage do |page|
        # WHEN: input an bad keyword
        page.input_keyword(BAD_KEYWORD)

        # THEN: danger flash notice should be seen
        page.flash_notice.must_include 'not found'
        page.flash_notice_element.attribute(:class).must_include 'danger'
      end
    end
  end
end
