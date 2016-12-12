# frozen_string_literal: true

# Represents course basic info in course-get result for JSON API output
class CourseBasicInfoRepresenter < Roar::Decorator
  include Roar::JSON

  property :title
  property :source
  property :introduction
  property :link
  property :photo
end
