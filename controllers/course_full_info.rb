# frozen_string_literal: true

# Share Learning web app
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get '/course_full_info' do
    result = GetCourseFullInfo.call(params)

    if result.success?
      @data = CourseFullInfoView.new(result.value)
      slim :course_full_info
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
