# frozen_string_literal: true

# Gets list of all groups from API
class GetCourseFullInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_course_id, lambda { |params|
    course_id = params[:course_id]

    if course_id
      Right(course_id: course_id, course_full_info: CourseFullInfo.new)
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
          "Unable to retrieve the basic info of Course #{course_id}: " \
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/courses/#{course_id}"
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
      # TODO: Implement value and representer objects for course prerequisites
      Right(input[:course_full_info])
    rescue
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :get_course_basic_info
      step :get_course_prerequisites
    end.call(params)
  end
end
