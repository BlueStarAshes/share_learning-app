# frozen_string_literal: true
require_relative 'course'

class CourseDetailsView
  SHORT_STR_SIZE = 200
  PLACEHOLDER_IMG_URL = 'http://placehold.it/100x100?text=G'

  attr_reader :udacity_count, :coursera_count, :youtube_count, \
    :udacity_courses, :coursera_courses, :youtube_courses

  def initialize(course_details)
    @udacity_count = course_details.udacity.count
    @coursera_count = course_details.coursera.count
    @youtube_count = course_details.youtube.count
    @udacity_courses = format_all_courses(course_details.udacity.courses)
    @coursera_courses = format_all_courses(course_details.coursera.courses)
    @youtube_courses = format_all_courses(course_details.youtube.courses)

  end

  private

  def format_all_courses(courses)
    new_courses = courses&.map do |course|
      formatted_course(course)
    end
  end

  def formatted_course(course)
    short_introduction = shortened(course.introduction, SHORT_STR_SIZE)
    photo_url = course.photo_url || PLACEHOLDER_IMG_URL

    CourseView.new(
      title = course.title, 
      main_introduction = short_introduction,
      resource_url = course.resource_url,
      photo_url = photo_url
    )
  end

  def original_attachment_url(attachment_url)
    return unless attachment_url
    CGI.unescape(attachment_url.gsub(FB_ATTACHED_URL_PREFIX, ''))
  end

  def shortened(str, size)
    return nil unless str
    str.length < size ? str : str[0..size].gsub(/\s\w+\s*$/,'...')
  end
end
