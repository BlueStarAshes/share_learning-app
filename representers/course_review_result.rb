# frozen_string_literal: true

# Represents review in review-get result for JSON API output
class CourseReviewResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :content
  property :created_time
end
