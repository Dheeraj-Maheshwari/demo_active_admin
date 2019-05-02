class ChargesController < ApplicationController
	# before_action :authenticate_user!
	protect_from_forgery :except => :webhooks
	skip_before_action :verify_authenticity_token

  def index
  end
	def new
		if params[:product_id].present?
			@product = Product.find(params[:product_id])
		end
	end

	def checkout_payment
    begin

    @amount = Product.find(params[:product_id]).try(:price)
    customer = Stripe::Customer.create(
       :email => params[:stripeEmail],
       :source  => params[:stripeToken]
     )

    charge = Stripe::Charge.create(
       :customer    => customer.id,
       :amount      => @amount,
       :description => 'Rails Stripe customer',
       :currency    => 'usd'
     )

 rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charges_path
    end
  end
	def update
	redirect_to charges_path
	end
end
