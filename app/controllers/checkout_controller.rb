class CheckoutController < ApplicationController

  def create
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          product: product.id,
          unit_amount: (product.price * 100).to_i, # Convert price to cents
          currency: "usd"
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })

    respond_to do |format|
      format.js
    end
  end

  private

  def product
    product = Product.find(params[:id])
  end
end


