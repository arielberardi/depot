# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end
end
