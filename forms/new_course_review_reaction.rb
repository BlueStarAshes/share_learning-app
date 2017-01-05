# frozen_string_literal: true

NewCourseReviewReaction = Dry::Validation.Form do
  required(:reaction_id).filled(:none?)
  required(:review_id).filled(:none?)
  required(:course_id).filled(:none?)
end
