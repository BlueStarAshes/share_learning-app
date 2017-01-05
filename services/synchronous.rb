# frozen_string_literal: true

# Gets list of all groups from API
class Synchronous
  COURSE_ID = 1

  def self.call
    begin
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}/courses/#{COURSE_ID}"
      )
      puts 'get_course_basic_info'
    rescue
      puts 'Disaster in get_course_basic_info~'
    end

    begin
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/prerequisite/#{COURSE_ID}"
      )
      puts 'get_course_prerequisites'
    rescue
      puts 'Disaster in get_course_prerequisites~'
    end

    begin
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/helpful/#{COURSE_ID}"
      )
      puts 'get_course_helpfulness_rating'
    rescue
      puts 'Disaster in get_course_helpfulness_rating~'
    end

    begin
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/difficulty/#{COURSE_ID}"
      )
      puts 'get_course_difficulty_rating'
    rescue
      puts 'Disaster in get_course_difficulty_rating~'
    end

    begin
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/#{COURSE_ID}/reviews"
      )
      puts 'get_course_reviews'
    rescue
      puts 'Disaster in get_course_reviews~'
    end
  end
end
