# frozen_string_literal: true

# Share Learning web app
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get '/course_full_info' do
    slim :course_full_info
  end
end
