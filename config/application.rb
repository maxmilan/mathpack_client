require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module MathpackClient
  class Application < Rails::Application
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.precompile += %w(*.svg *.eot *.woff *.ttf)

    config.i18n.default_locale = :ru
  end
end
