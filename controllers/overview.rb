# frozen_string_literal: true
require 'json'

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  # Home page: show number of courses each resource contains

  get "/?" do
    result = GetCoursesOverview.call

    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end

    slim :overview
  end
end
