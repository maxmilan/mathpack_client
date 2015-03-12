require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module MathpackClient
  class Application < Rails::Application
    config.assets.precompile += %w(*.svg *.eot *.woff *.ttf)
  end
end
