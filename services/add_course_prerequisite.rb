# frozen_string_literal: true

# Post a new course prerequisite through API
class AddCoursePrerequisite
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

  register :post_prerequisite, lambda { |input|
    begin
      course_id = input[:course_id]
      prerequisite = input[:prerequisite]
      Right(
        HTTP.post(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/prerequisite/#{course_id}",
          json: { prerequisite: prerequisite }
        )
      )
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  def self.call(input)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :post_prerequisite
    end.call(input)
  end
end