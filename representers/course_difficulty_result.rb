# frozen_string_literal: true

# Represents prerequisite in difficulty-get result for JSON API output
class CourseDifficultyResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :avg_rating
end
