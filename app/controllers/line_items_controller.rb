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
        format.turbo_stream { @current_item = @line_item }
        format.html { redirect_to store_index_url }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end
end
