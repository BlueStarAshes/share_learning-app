# frozen_string_literal: true

# Page object for course full info view (course page)
class CourseFullInfoPage
  include PageObject

  HOST = 'http://localhost:9000'.freeze
  FIRST_COURSE_ID = 1

  page_url "#{HOST}/course_full_info?course_id=#{FIRST_COURSE_ID}"

  h1(:heading)
  h2(:course_title, id: 'course_title')

  h4(:course_prerequisite_header, id: 'course_prerequisite_header')
  h4(:course_helpfulness_header, id: 'course_helpfulness_header')
  h4(:course_difficulty_header, id: 'course_difficulty_header')
  h4(:course_source_header, id: 'course_source_header')
  h4(:course_information_header, id: 'course_information_header')
  h4(:course_link_header, id: 'course_link_header')

  li(:course_source, id: 'course_source')
  p(:course_information, id: 'course_information')
  a(:course_link, id: 'course_link')

  img(:course_photo, id: 'course_photo')
  button(:new_review, name: 'new_review')
end
