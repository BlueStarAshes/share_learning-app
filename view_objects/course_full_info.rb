# frozen_string_literal: true
require_relative 'course'

# View object for course full info page
class CourseFullInfoView
  attr_reader(
    :title,
    :source,
    :info,
    :link,
    :photo,
    :prerequisites,
    :helpfulness_rating,
    :difficulty_rating,
    :reviews
  )

  def initialize(course_full_info)
    @title = course_full_info.basic_info.title
    @source = course_full_info.basic_info.source
    @info = course_full_info.basic_info.introduction
    @link = course_full_info.basic_info.link
    @photo = course_full_info.basic_info.photo
    @prerequisites = course_full_info.prerequisites
    @helpfulness_rating = course_full_info.helpfulness_rating
    @difficulty_rating = course_full_info.difficulty_rating
    @reviews = course_full_info.reviews
  end
end
