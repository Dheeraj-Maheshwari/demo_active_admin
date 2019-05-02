class ProductsController < ApplicationController

	def index
		 @products = Product.all
	end 
	def new
		@product = Product.new
	end 

	def create
			product = Product.new(product_params)
		if product.save
			 redirect_to product
		else
			render :new
		end
	end
	def edit 
		@product = Product.find(params[:id])
	end

	def update
		product = Product.find(params[:id])
		if product.update_attributes(product_params)
			redirect_to product
		else
			render :edit
		end
	end

	def show
		if params[:PayerID].present?
			redirect_to root_path
			# render :success
		else
			@product = Product.find(params[:id])
		end
	end

	def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path
  end

  # def express
		# product = Product.find(params[:product_id])
 	# 	response = EXPRESS_GATEWAY.setup_purchase(product.try(:price).to_i,
		# ip: request.remote_ip,
		# return_url: url_for(:action => 'complete', :id => product.id),
		# cancel_return_url: "http://localhost:3000/products",
		# currency: "USD",
		# allow_guest_checkout: true,
		# items: [{name: product.try(:name), quantity: "1", amount: product.try(:price).to_i}]
		# )
		# redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  # end

 #  def complete
	# 	product = Product.find(params[:product_id])
	#  begin
	# 	purchase = EXPRESS_GATEWAY.purchase(Product.find(params[:product_id]).try(:price),
	# 	:ip => request.remote_ip,
	# 	:payer_id => params[:PayerID],
	# 	:token => params[:token]
	# 	)
	# 	puts(purchase)
	#  rescue Exception => e
	# 	  logger.error "Paypal error while creating payment: #{e.message}"

	# 	  flash[:error] = e.message
	# end
	# 	unless purchase.success?
	# 	  flash[:error] = "Unfortunately an error occurred:" + purchase.message
	# 	else
	# 	  flash[:notice] = "Thank you for your payment"
	# 	end
	# 	  redirect_to products_path
 #  end

	private

	def product_params
		params.require(:product).permit(:name,:price,:avatar,:email)
	end
end
