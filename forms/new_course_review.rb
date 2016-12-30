# frozen_string_literal: true

NewCourseReview = Dry::Validation.Form do
  required(:review_content).filled(:none?)
  required(:course_id).filled(:none?)

  configure do
    config.messages_file = File.join(__dir__, 'errors/new_course_review.yml')
  end
end
