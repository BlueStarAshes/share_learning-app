# frozen_string_literal: true

# Represents course full info in course-get result for JSON API output
class CourseFullInfoRepresenter < Roar::Decorator
  include Roar::JSON

  property(
    :basic_info,
    extend: CourseBasicInfoRepresenter,
    class: CourseBasicInfo
  )
end
