# frozen_string_literal: true

# Gets list of all groups from API
class Ratings
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    results = HTTP.get("#{ShareLearningApp.config.SHARE_LEARNING_API}/helpful/"+ params[:course_id] )

    Right(SearchResultsRepresenter.new(SearchResults.new).from_json(results.body))
  rescue
    Left(Error.new('Cannot rate course helpfulness'))
  end
end