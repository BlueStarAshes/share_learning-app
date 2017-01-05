# frozen_string_literal: true
require_relative 'review_reaction_result'

# Represents review_reactions in review_reaction-get result for JSON API output
class ReviewReactionsResultRepresenter < Roar::Decorator
  include Roar::JSON

  collection(
    :reactions,
    extend: ReviewReactionResultRepresenter,
    class: ReviewReactionResult
  )
end
