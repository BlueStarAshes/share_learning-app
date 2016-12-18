# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Course_full_info Page' do
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
      # GIVEN: user goes to the course page
      visit CourseFullInfoPage do |page|
        # THEN: user should see correct title, header, 'new review' button
        page.title.must_include 'ShareLearning'
        page.heading.must_include 'ShareLearning'

        page.new_review?
      end
    end

    it '(HAPPY) should see content' do
      # GIVEN: user goes to the course page
      visit CourseFullInfoPage do |page|
        # THEN: user should see the course title, course photo, course
        # prerequisite (& header), course helpfulness rating (& header),
        # course difficulty rating (& header), course source (& header),
        # course information (& header), and course link (& header)
        page.course_title.length.must_be :>, 0
        page.course_photo_element.attribute(:src).length.must_be :>, 0

        page.course_prerequisite_header.must_include 'Prerequisite'
        page.course_helpfulness_header.must_include 'Helpfulness'
        page.course_difficulty_header.must_include 'Difficulty'
        page.course_source_header.must_include 'Source'
        page.course_information_header.must_include 'Information'
        page.course_link_header.must_include 'Link'

        page.course_source.length.must_be :>, 0
        page.course_information.length.must_be :>, 0
        page.course_link_element.attribute(:href).length.must_be :>, 0
      end
    end
  end
end
