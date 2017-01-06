# frozen_string_literal: true

# Gets list of all groups from API
class Rating
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :call_api_to_create_rating, lambda { |params|
  	type = params['type']
  	course_id = params['course_id']
  	if !params['helpfulness_rating'].nil?
  	  rating = params['helpfulness_rating']
  	elsif !params['difficulty_rating'].nil?
  		rating = params['difficulty_rating']
  	end  		

    begin
      results = HTTP.post(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}/#{type}/#{course_id}", 
        json: { rating: rating.to_i }
      )      

      Right(results.body)
    rescue
      if type == 'helpful'
      	Left(Error.new('Cannot rate course helpfulness'))
      elsif type == 'difficulty'
      	Left(Error.new('Cannot rate course difficulty'))
      end
      	
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :call_api_to_create_rating
    end.call(params)
  end
end