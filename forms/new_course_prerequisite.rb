# frozen_string_literal: true

Prerequisite = Dry::Validation.Form do
  required(:course_name).filled(:none?)
  required(:course_id).filled(:none?)

  configure do
    config.messages_file = File.join(__dir__, 'errors/new_course_prerequisite.yml')
  end
end
