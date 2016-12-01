# frozen_string_literal: true

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get "/search" do
    search_keyword = Search.call(params)
    results = GetSearchCourse.call(search_keyword)
    
    if results.success? 
      @data = results.value         
      @keyword = search_keyword.output[:search_keyword]
    else
       flash[:error] = results.value.message
       redirect '/'
    end

    slim :search
  end
end
