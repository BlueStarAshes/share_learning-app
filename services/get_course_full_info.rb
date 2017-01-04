# frozen_string_literal: true

# Gets list of all groups from API
class GetCourseFullInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_course_id, lambda { |params|
    course_id = params[:course_id]

    if course_id
      course_full_info = CourseFullInfo.new
      course_full_info.course_id = course_id
      Right(course_id: course_id, course_full_info: course_full_info)
    else
      Left(Error.new('Course id cannot be empty'))
    end
  }

  register :get_course_basic_info, lambda { |input|
    begin
      course_id = input[:course_id]
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/courses/#{course_id}"
        )

      input[:course_full_info].basic_info =
        CourseBasicInfoRepresenter.new(CourseBasicInfo.new).from_json(
          result.body
        )

      Right(input)
    rescue
      Left(
        Error.new(
          "Unable to retrieve the basic info of Course #{course_id}"
        )
      )
    end
  }

  register :get_course_prerequisites, lambda { |input|
    begin
      course_id = input[:course_id]
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
          "/course/prerequisite/#{course_id}"
        )

      input[:course_full_info].prerequisites =
        CoursePrerequisitesResultRepresenter.new(
          CoursePrerequisitesResult.new
        ).from_json(
          result.body
        ).prerequisites

      Right(input)
    rescue
      Left(
        Error.new(
          "Unable to retrieve prerequisites of Course #{course_id}"
        )
      )
    end
  }

  register :get_course_helpfulness_rating, lambda { |input|
    begin
      course_id = input[:course_id]
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
          "/course/helpful/#{course_id}"
        )

      input[:course_full_info].helpfulness_rating =
        CourseHelpfulnessResultRepresenter.new(
          CourseHelpfulnessResult.new
        ).from_json(
          result.body
        ).avg_rating

      Right(input)
    rescue
      Left(
        Error.new(
          "Unable to retrieve helpfulness rating of Course #{course_id}"
        )
      )
    end
  }

  register :get_course_difficulty_rating, lambda { |input|
    begin
      course_id = input[:course_id]
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
          "/course/difficulty/#{course_id}"
        )

      input[:course_full_info].difficulty_rating =
        CourseDifficultyResultRepresenter.new(
          CourseDifficultyResult.new
        ).from_json(
          result.body
        ).avg_rating

      Right(input)
    rescue
      Left(
        Error.new(
          "Unable to retrieve difficulty rating of Course #{course_id}"
        )
      )
    end
  }

  register :get_course_reviews, lambda { |input|
    begin
      course_id = input[:course_id]
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
          "/course/#{course_id}/reviews"
        )

      input[:course_full_info].reviews =
        CourseReviewsResultRepresenter.new(
          CourseReviewsResult.new
        ).from_json(
          result.body
        ).reviews

      Right(input)
    rescue
      Left(
        Error.new(
          "Unable to retrieve reviews of Course #{course_id}"
        )
      )
    end
  }

  register :get_reactions, lambda { |input|
    begin
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}" \
          '/reactions'
        )

      input[:course_full_info].reactions =
        ReactionsResultRepresenter.new(
          ReactionsResult.new
        ).from_json(
          result.body
        ).reactions

      Right(input)
    rescue
      Left(
        Error.new(
          'Unable to retrieve reactions'
        )
      )
    end
  }

  register :return_course_full_info, lambda { |input|
    Right(input[:course_full_info])
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :get_course_basic_info
      step :get_course_prerequisites
      step :get_course_helpfulness_rating
      step :get_course_difficulty_rating
      step :get_course_reviews
      step :get_reactions
      step :return_course_full_info
    end.call(params)
  end
end
