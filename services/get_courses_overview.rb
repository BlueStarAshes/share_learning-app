# frozen_string_literal: true

# Gets list of all groups from API
class GetCoursesOverview
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{ShareLearningApp.config.SHARE_LEARNING_API}/overview")
    Right(OverviewResultRepresenter.new(OverviewResult.new).from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
