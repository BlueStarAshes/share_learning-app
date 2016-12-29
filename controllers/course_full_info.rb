# frozen_string_literal: true

# Share Learning web app
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  get '/course_full_info' do
    result = GetCourseFullInfo.call(params)

    if result.success?
      course_full_info = result.value
      @course_id = params[:course_id]
      @data = CourseFullInfoView.new(course_full_info)
      slim :course_full_info
    else
      flash[:error] = result.value.message
      redirect '/'
    end
  end

  post '/course_full_info/new_review' do
    new_course_review = NewCourseReview(params)
    result = AddCourseReview.call(new_course_review)

    if result.success?
      flash[:notice] = 'Review successfully added'
    else
      flash[:error] = result.value.message
    end

    # redirect "/course_full_info?course_id=#{@course_id}"
    redirect '/'
  end
end
