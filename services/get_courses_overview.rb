# frozen_string_literal: true

# Gets list of all groups from API
class GetCoursesOverview
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{ShareLearningApp.config.ShareLearning_API}/overview")
    Right(results)
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end