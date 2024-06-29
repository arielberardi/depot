# frozen_string_literal: true

class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[create]

  # POST /line_items or /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    if @line_item.save
      redirect_to cart_url(@line_item.cart), notice: I18n.t('line_item.notice.created')
    else
      render :new, status: :unprocessable_entity
    end
  end
end
