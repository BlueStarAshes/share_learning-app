# frozen_string_literal: true

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  post "/rate_helpfulness" do
    helpfulness_rating = Rating.call(params, 'helpfulness')
     
    if course_details.success? 
      results = course_details.value 
      @data = CourseDetailsView.new(results)
      
      if @data.udacity_count.nonzero? || @data.coursera_count.nonzero? \
       || @data.youtube_count.nonzero?
        @keyword = search_keyword.output[:search_keyword]
      else
        flash.now[:error] = 'Course not found'
      end
      slim :search

    else
       flash[:error] = course_details.value.message
       redirect '/'
    end
  end
end