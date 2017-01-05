# frozen_string_literal: true

# Post a new course review reaction through API
class AddCourseReviewReaction
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

  register :validate_review_id, lambda { |input|
    if input[:review_id]
      Right(input)
    else
      Left(
        Error.new('Review ID cannot be empty!')
      )
    end
  }

  register :validate_reaction_id, lambda { |input|
    if input[:reaction_id]
      Right(input)
    else
      Left(
        Error.new('Reaction ID cannot be empty!')
      )
    end
  }

  register :call_api_to_post_review_reaction, lambda { |input|
    begin
      review_id = input[:review_id]
      reaction_id = input[:reaction_id]
      Right(
        HTTP.post(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/reactions/new_review_reaction",
          json: { review_id: review_id, reaction_id: reaction_id }
        )
      )
    rescue
      Left(
        Error.new(
          "Our servers failed - we are investigating!"
        )
      )
    end
  }

  def self.call(input)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :validate_review_id
      step :validate_reaction_id
      step :call_api_to_post_review_reaction
    end.call(input)
  end
end
