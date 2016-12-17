# frozen_string_literal: true
require_relative 'course_prerequisite_result'

# Represents prerequisites in prerequisite-get result for JSON API output
class CoursePrerequisitesResultRepresenter < Roar::Decorator
  include Roar::JSON

  collection(
    :prerequisites,
    extend: CoursePrerequisiteResultRepresenter,
    class: CoursePrerequisiteResult
  )
end
