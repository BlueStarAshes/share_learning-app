# frozen_string_literal: true

# Post a new course review through API
class AddCourseReview
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_course_id, lambda { |new_course_review|
    if new_course_review[:course_id]
      puts "Course ID: #{params[:course_id]}"
      Right(params)
    else
      Left(
        Error.new("Course ID cannot be empty!;#{new_course_review[:content]}")
      )
    end
  }

  register :call_api_to_post_review, lambda { |new_course_review|
    begin
      course_id = new_course_review[:course_id]
      content = new_course_review[:content]
      Right(
        HTTP.post(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/reviews/#{course_id}",
          json: { course_id: course_id, request: content }
        )
      )
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  def self.call(new_course_review)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :call_api_to_post_review
    end.call(new_course_review)
  end
end
