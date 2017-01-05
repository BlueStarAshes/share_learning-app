# frozen_string_literal: true

# Post a new course review through API
class AddCourseReview
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_course_id, lambda { |input|
    if input[:course_id]
      Right(input)
    else
      Left(
        Error.new('Course ID cannot be empty!')
      )
    end
  }

  register :call_api_to_post_review, lambda { |input|
    begin
      course_id = input[:course_id]
      content = input[:content]
      Right(
        HTTP.post(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/reviews/#{course_id}",
          json: { content: content }
        )
      )
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  def self.call(input)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :call_api_to_post_review
    end.call(input)
  end
end
