# frozen_string_literal: true
require_relative 'course_review_result'

# Represents reviews in reviews-get result for JSON API output
class CourseReviewsResultRepresenter < Roar::Decorator
  include Roar::JSON

  collection(
    :reviews,
    extend: CourseReviewResultRepresenter,
    class: CourseReviewResult
  )
end
