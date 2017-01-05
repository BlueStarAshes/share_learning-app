# frozen_string_literal: true

# Represents review_reaction in review_reaction-get result for JSON API output
class ReviewReactionResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :type
  property :count
end
