# frozen_string_literal: true

# Gets list of all groups from API
class GetCourseFullInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_course_id, lambda { |params|
    course_id = params[:course_id]

    if course_id
      course_full_info = CourseFullInfo.new
      Right(course_id: course_id, course_full_info: course_full_info)
    else
      Left(Error.new('Course id cannot be empty'))
    end
  }

  register :get_course_basic_info, lambda { |intput|
    begin
      course_id = intput[:course_id]
      result =
        HTTP.get(
          "#{ShareLearningApp.config.SHARE_LEARNING_API}/courses/" +
          course_id
        )

      input[:course_full_info].basic_info =
        CourseBasicInfoRepresenter.new(CourseBasicInfo.new).from_json(
          result.body
        )
      Right(input[:course_full_info])
    rescue
      Left(
        Error.new(
          "Unable to retrieve the basic info of Course #{course_id}"
        )
      )
    end
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_course_id
      step :get_course_basic_info
    end.call(params)
  end
end
