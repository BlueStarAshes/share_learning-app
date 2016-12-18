# frozen_string_literal: true

CourseFullInfo =
  Struct.new(
    :basic_info,
    :prerequisites,
    :helpfulness_rating,
    :difficulty_rating,
    :reviews
  )
