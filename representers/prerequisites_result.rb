# frozen_string_literal: true
require_relative 'prerequisite_result'

# Represents course in search results for JSON API output
class PrerequisitesResultRepresenter < Roar::Decorator
  include Roar::JSON

  collection(
    :prerequisites,
    extend: PrerequisiteResultRepresenter,
    class: PrerequisiteResult
  )
end
