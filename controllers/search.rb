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
      @keyword = search_keyword.output[:search_keyword]
      slim :search
    else
       flash[:error] = course_details.value.message
       redirect '/'
    end
  end
end
