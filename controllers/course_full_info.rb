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

  post '/course_full_info/new_review_reaction' do
    new_course_review_reaction = NewCourseReviewReaction.call(params)
    result = AddCourseReviewReaction.call(
      course_id: new_course_review_reaction[:course_id],
      review_id: new_course_review_reaction[:review_id],
      reaction_id: new_course_review_reaction[:reaction_id]
    )

    unless result.success?
      flash[:error] = result.value.message
    end

    redirect "/course_full_info?course_id=#{new_course_review_reaction[:course_id]}"
  end

  post '/course_full_info/new_prerequisite' do
    new_prerequisite = Prerequisite.call(params)
    print new_prerequisite[:course_id]
    result = AddCoursePrerequisite.call(
      course_id: new_prerequisite[:course_id],
      prerequisite: new_prerequisite[:course_name]
    )

    if result.success?
      flash[:notice] = 'Prerequisite successfully added'
    else
      flash[:error] = result.value.message
    end

    redirect "/course_full_info?course_id=#{new_prerequisite[:course_id]}"
  end  
end
