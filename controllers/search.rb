# frozen_string_literal: true
require 'json'
# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get "/search/:search_keyword/?" do
    results = GetSearchCourse.call(params)
    search = JSON.parse(results.value)
    coursera = search["coursera"]["courses"]
    udacity = search["udacity"]["courses"]
    youtube = search["youtube"]["courses"]

    if results.success?
      @keyword = params[:search_keyword]
      @coursera = coursera
      @coursera_count = search["coursera"]["count"]
      @udacity = udacity
      @udacity_count = search["udacity"]["count"]
      @youtube = youtube
      @youtube_count = search["youtube"]["count"]
    else
       flash[:error] = result.value.message
    end

    slim :search
  end
end
