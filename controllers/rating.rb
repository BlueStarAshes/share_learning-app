# frozen_string_literal: true

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  post "/rate_helpfulness" do
    params['type'] = 'helpful'
    puts params
    helpfulness_rating = Rating.call(params)
     
    if helpfulness_rating.success? 
      flash[:notice] = 'Successfully rate the helpfulness of the course'
      redirect "/course_full_info?course_id=#{params[:course_id]}"

    else
       flash[:error] = helpfulness_rating.value.message
       redirect "/course_full_info?course_id=#{params[:course_id]}"
    end
  end

  post "/rate_difficulty" do
    params['type'] = 'difficulty'
    puts params
    difficulty_rating = Rating.call(params)
     
    if difficulty_rating.success? 
      flash[:notice] = 'Successfully rate the difficulty of the course'
      redirect "/course_full_info?course_id=#{params[:course_id]}"

    else
       flash[:error] = difficulty_rating.value.message
       redirect "/course_full_info?course_id=#{params[:course_id]}"
    end
  end  
end