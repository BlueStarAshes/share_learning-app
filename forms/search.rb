# frozen_string_literal: true

Search = Dry::Validation.Form do
  required(:search_keyword).filled(:none?)

  configure do
    config.messages_file = File.join(__dir__, 'errors/search.yml')
  end
end
