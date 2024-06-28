# frozen_string_literal: true

class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[create]

  # POST /line_items or /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_path(@line_item.cart), notice: I18n.t('line_item.notice.created') }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
end
