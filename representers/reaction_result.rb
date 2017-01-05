# frozen_string_literal: true

# Represents review in review-get result for JSON API output
class ReactionResultRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :type
  property :emoji
end
