# frozen_string_literal: true
require 'json'
# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get "/search" do
    search_keyword = Search.call(params)
    results = GetSearchCourse.call(search_keyword)
    
    if results.success? 
      search = JSON.parse(results.value)
      begin
        @coursera = search["coursera"]["courses"]
        @coursera_count = search["coursera"]["count"]
      rescue 
        @coursera = nil
        @coursera_count = 0
      end
      begin
        @udacity = search["udacity"]["courses"]
        @udacity_count = search["udacity"]["count"]
      rescue 
        @udacity = nil
        @udacity_count = 0
      end
      begin
        @youtube = search["youtube"]["courses"]
        @youtube_count = search["youtube"]["count"]
      rescue 
        @youtube = nil
        @youtube_count = 0
      end          
      @keyword = search_keyword.output[:search_keyword]
    else
       flash[:error] = results.value.message
       redirect '/'
    end

    slim :search
  end
end

