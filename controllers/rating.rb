# frozen_string_literal: true

# Share Learning API web service
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut
  helpers Sinatra::Cookies

  post "/rate_helpfulness" do
    params['type'] = 'helpful'
    puts params

    if "#{cookies[:rate_helpfulness]}" == 'true'
      flash[:error] = 'Have rated the helpfulness of the course'
      redirect "/course_full_info?course_id=#{params[:course_id]}"
    else
      helpfulness_rating = Rating.call(params)

      if helpfulness_rating.success? 
        flash[:notice] = 'Successfully rate the helpfulness of the course'
        cookies[:rate_helpfulness] = 'true'
        redirect "/course_full_info?course_id=#{params[:course_id]}"

      else
         flash[:error] = helpfulness_rating.value.message
         redirect "/course_full_info?course_id=#{params[:course_id]}"
      end
    end
  end

  post "/rate_difficulty" do
    params['type'] = 'difficulty'
    puts params

    if "#{cookies[:rate_difficulty]}" == 'true'
      flash[:error] = 'Have rated the difficulty of the course'
      redirect "/course_full_info?course_id=#{params[:course_id]}"
    else      
      difficulty_rating = Rating.call(params)
       
      if difficulty_rating.success? 
        flash[:notice] = 'Successfully rate the difficulty of the course'
        cookies[:rate_difficulty] = 'true'
        redirect "/course_full_info?course_id=#{params[:course_id]}"

      else
         flash[:error] = difficulty_rating.value.message
         redirect "/course_full_info?course_id=#{params[:course_id]}"
      end
    end
  end  
end