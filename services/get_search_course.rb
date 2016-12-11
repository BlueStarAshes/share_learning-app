# frozen_string_literal: true

# Gets list of all groups from API
class GetSearchCourse
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    keyword = (params[:search_keyword].split(' ')).join("+")
    results = HTTP.get("#{ShareLearningApp.config.SHARELEARNING_API}/search/"+keyword)
    
    Right(SearchResultsRepresenter.new(SearchResults.new).from_json(results.body))
  rescue
    Left(Error.new('Please enter an keyword'))
  end
end
