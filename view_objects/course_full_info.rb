# frozen_string_literal: true
require_relative 'course'

# View object for course full info page
class CourseFullInfoView
  attr_reader(
    :course_id,
    :title,
    :source,
    :info,
    :link,
    :photo,
    :prerequisites,
    :helpfulness_rating,
    :difficulty_rating,
    :reviews,
    :reactions
  )

  def initialize(course_full_info)
    @course_id = course_full_info.course_id
    @title = course_full_info.basic_info.title
    @source = course_full_info.basic_info.source
    @info = course_full_info.basic_info.introduction
    @link = course_full_info.basic_info.link
    @photo = course_full_info.basic_info.photo
    @prerequisites = course_full_info.prerequisites
    @helpfulness_rating = course_full_info.helpfulness_rating
    @difficulty_rating = course_full_info.difficulty_rating
    @reviews = course_full_info.reviews
    @reactions = course_full_info.reactions
  end
end
