# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show; end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    redirect_to store_index_url, notice: I18n.t('cart.notice.destroy')
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def invalid_cart
    logger.error "Attemp to access invalid cart #{params[:id]}"
    redirect_to store_index_url, notice: I18n.t('cart.error.invalid_cart')
  end
end
