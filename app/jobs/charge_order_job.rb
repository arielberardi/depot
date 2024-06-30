# frozen_string_literal: true

class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(_order, _pay_type_params)
    OrderMailer.received(@order).deliver_later

    # Mock service
    # PayService.make_payment(order, pay_type_params)
  end
end
