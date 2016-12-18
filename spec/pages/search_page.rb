# frozen_string_literal: true

# Page object for search view
class SearchPage
  include PageObject

  page_url 'http://localhost:9000/search?search_keyword=machine+learning'

  h1(:heading)
  div(:flash_notice, class: 'alert')
  button(:search_btn, name: 'btn-search')
  text_field(:keyword_input, name: 'search_keyword')
  p(:counts, class: 'results_count')
  table(:courses_table, id: 'course_table')
  indexed_property(
    :courses,
    [
      [:img, :img, { id: 'course[%s].img' }],
      [:h4, :title, { id: 'course[%s].title' }],
      [:p, :intro, { id: 'course[%s].intro' }],
      [:button, :link, { id: 'course[%s].link' }]
    ]
  )

  def courses_count
    browser.trs(class: 'course_row').count
  end

  def first_row
    courses[0]
  end

  def input_keyword(keyword)
    self.keyword_input = keyword
    search_btn
  end
end
