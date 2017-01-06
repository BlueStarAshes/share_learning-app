# frozen_string_literal: true

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  post "/rate_helpfulness" do
    params['type'] = 'helpful'
    puts params
    helpfulness_rating = Rating.call(params)
     
    if helpfulness_rating.success? 
      results = helpfulness_rating.value 
      # @data = CourseDetailsView.new(results)
      
      # if @data.udacity_count.nonzero? || @data.coursera_count.nonzero? \
      #  || @data.youtube_count.nonzero?
      #   @keyword = search_keyword.output[:search_keyword]
      # else
      #   flash.now[:error] = 'Course not found'
      # end
      redirect "/course_full_info?course_id=#{params[:course_id]}"

    else
       flash[:error] = helpfulness_rating.value.message
       redirect "/course_full_info?course_id=#{params[:course_id]}"
    end
  end
end