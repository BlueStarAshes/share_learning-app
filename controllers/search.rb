# frozen_string_literal: true

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get "/search" do
    search_keyword = Search.call(params)
    course_details = GetSearchCourse.call(search_keyword) 
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
