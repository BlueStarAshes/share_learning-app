# frozen_string_literal: true

# Share Learning web app
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get '/course_full_info' do
    result = GetCourseFullInfo.call(params)

    if result.success?
      course_full_info = result.value
      @data = CourseFullInfoView.new(course_full_info)
      slim :course_full_info
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end
end
