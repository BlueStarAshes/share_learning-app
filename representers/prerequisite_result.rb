# frozen_string_literal: true

# Represents course in search results for JSON API output
class PrerequisiteResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :course_name
end
