# frozen_string_literal: true
require_relative 'course_prerequisite_result'

# Represents course in search results for JSON API output
class CoursePrerequisitesResultRepresenter < Roar::Decorator
  include Roar::JSON

  collection(
    :prerequisites,
    extend: CoursePrerequisiteResultRepresenter,
    class: CoursePrerequisiteResult
  )
end
