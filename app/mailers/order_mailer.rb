# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def received(order)
    @order = order

    mail to: order.email, subject: I18n.t('mailer.order.received.subject')
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: I18n.t('mailer.order.shipped.subject')
  end
end
