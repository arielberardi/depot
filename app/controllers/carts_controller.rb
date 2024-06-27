# frozen_string_literal: true

class CartsController < ApplicationController
  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end
end
