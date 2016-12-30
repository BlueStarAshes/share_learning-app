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

  post '/course_full_info/new_review' do
    new_course_review = NewCourseReview.call(params)
    result = AddCourseReview.call(
      course_id: new_course_review[:course_id],
      content: new_course_review[:review_content]
    )

    if result.success?
      flash[:notice] = 'Review successfully added'
    else
      flash[:error] = result.value.message
    end

    redirect "/course_full_info?course_id=#{new_course_review[:course_id]}"
  end
end
