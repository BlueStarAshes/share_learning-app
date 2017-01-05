# frozen_string_literal: true

CourseFullInfo =
  Struct.new(
    :course_id,
    :basic_info,
    :prerequisites,
    :helpfulness_rating,
    :difficulty_rating,
    :reviews,
    :reactions,
    :all_review_reactions
  )
