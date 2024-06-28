# frozen_string_literal: true

class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @cart = Cart.find(params[:id])
  end

  private

  def invalid_cart
    logger.error "Attemp to access invalid cart #{params[:id]}"
    redirect_to store_index_path, notice: I18n.t('cart.errors.invalid_cart')
  end
end
