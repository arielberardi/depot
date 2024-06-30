# frozen_string_literal: true

class OrdersController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_is_not_empty, only: %i[new]
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil

      OrderMailer.received(@order).deliver_later

      redirect_to store_index_url, notice: I18n.t('order.notice.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    if @order.update(order_params)
      redirect_to order_url(@order), notice: I18n.t('order.notice.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    redirect_to orders_url, notice: I18n.t('order.notice.destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def ensure_cart_is_not_empty
    redirect_to store_index_path, notice: I18n.t('order.notice.empty_cart') if @cart.line_items.empty?
  end
end
