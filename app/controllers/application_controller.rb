class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  around_filter :set_locale

  private

  def set_locale
    original_locale = I18n.locale
    available = %w[ru en]

    I18n.locale = if available.include?(locale = params[:locale].to_s.downcase)
                    locale
                  else
                    I18n.default_locale
                  end

    yield
  ensure
    I18n.locale = original_locale
  end
end
