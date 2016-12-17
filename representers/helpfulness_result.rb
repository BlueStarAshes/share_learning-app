# frozen_string_literal: true

# Represents prerequisite in helpful-get result for JSON API output
class HelpfulnessResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :avg_rating
end
