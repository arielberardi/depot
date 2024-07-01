# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale_from_params

  protected

  def set_locale_from_params
    return unless params[:locale]

    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = "Missing translations for #{params[:locale]}"
      logger.error = "Missing translations for #{params[:locale]}"
    end
  end
end
