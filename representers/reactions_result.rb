# frozen_string_literal: true
require_relative 'reaction_result'

# Represents reactions in reactions-get result for JSON API output
class ReactionsResultRepresenter < Roar::Decorator
  include Roar::JSON

  collection(
    :reactions,
    extend: ReactionResultRepresenter,
    class: ReactionResult
  )
end
