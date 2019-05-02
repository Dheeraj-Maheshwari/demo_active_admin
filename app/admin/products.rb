ActiveAdmin.register Product do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
 controller do
 #    def index
	# 	 @products = Product.all
	# end 
	# def new
	# 	@product = Product.new
	# end 

	def create
			product = Product.new(product_params)
		if product.save
			 redirect_to admin_products_path
		else
			render :new
		end
	end
	# def edit 
	# 	@product = Product.find(params[:id])
	# end

	# def update
	# 	product = Product.find(params[:id])
	# 	if product.update_attributes(product_params)
	# 		redirect_to product
	# 	else
	# 		render :edit
	# 	end
	# end

	def show
		@product = Product.find(params[:id])
	end

	def destroy
		
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path
  end

	private

	def product_params
		
		params.require(:product).permit(:name,:price,:avatar,:description)
	end
end
end
