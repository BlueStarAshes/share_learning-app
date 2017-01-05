# frozen_string_literal: true

# Gets list of all groups from API
class Asynchronous
  COURSE_ID = 1

  def self.call
    result_basic_info = Concurrent::Promise
    .execute do
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}/courses/#{COURSE_ID}"
      )
    end
    .then do
      puts 'get_course_basic_info'
    end
    .rescue do
      puts 'Disaster in get_course_basic_info~'
    end

    result_course_prerequisites = Concurrent::Promise
    .execute do
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/prerequisite/#{COURSE_ID}"
      )
    end
    .then do
      puts 'get_course_prerequisites'
    end
    .rescue do
      puts 'Disaster in get_course_prerequisites~'
    end

    result_course_helpfulness_rating = Concurrent::Promise
    .execute do
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/helpful/#{COURSE_ID}"
      )
    end
    .then do
      puts 'get_course_helpfulness_rating'
    end
    .rescue do
      puts 'Disaster in get_course_helpfulness_rating~'
    end

    result_course_difficulty_rating = Concurrent::Promise
    .execute do
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/difficulty/#{COURSE_ID}"
      )
    end
    .then do
      puts 'get_course_difficulty_rating'
    end
    .rescue do
      puts 'Disaster in get_course_difficulty_rating~'
    end

    result_course_reviews = Concurrent::Promise
    .execute do
      HTTP.get(
        "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
        "/course/#{COURSE_ID}/reviews"
      )
    end
    .then do
      puts 'get_course_reviews'
    end
    .rescue do
      puts 'Disaster in get_course_reviews~'
    end

    while result_basic_info.pending? &&
          result_course_prerequisites.pending? &&
          result_course_helpfulness_rating.pending? &&
          result_course_difficulty_rating.pending? &&
          result_course_reviews.pending?
    end
  end
end
