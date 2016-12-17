# frozen_string_literal: true

# Represents prerequisite in prerequisite-get result for JSON API output
class PrerequisiteResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :course_name
end
