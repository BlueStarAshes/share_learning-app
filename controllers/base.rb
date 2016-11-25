# frozen_string_literal: true
configure :development do
  def reload!
    # Tux reloading: https://github.com/cldwalker/tux/issues/3
    exec $PROGRAM_NAME, *ARGV
  end
end

# configure web application
class ShareLearningApp < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
    # Setting Youtube API key
    YouTube::YouTubeAPI.config.update(api_key: config.YOUTUBE_API_KEY)
  end

  use Rack::Session::Cookie, secret: ShareLearningApp.config.SECRET
  use Rack::Flash

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  after do
    content_type 'text/html'
  end
end
