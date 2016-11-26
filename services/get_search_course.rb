# frozen_string_literal: true

# Gets list of all groups from API
class GetSearchCourse
  extend Dry::Monads::Either::Mixin

  def self.call(params)
  	keyword = (params[:search_keyword].split(' ')).join("+")
    results = HTTP.get("#{ShareLearningApp.config.ShareLearning_API}/search/"+keyword)
    Right(results.body)
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end