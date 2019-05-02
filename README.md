# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...Bank Account
Account Number:
28312748
Routing Number:
209778
Credit Card
Credit Card Number:
4462674895810807
Credit Card Type:
VISA
Expiration Date:
05/2024
PayPal
Balance:
9999.00 GBP


1. Add gem 'activemerchant' in Gemfile and bundle. 

2. Create a individual account on paypal. 

3. Create two new accounts for buyer and faciliator in sandbox and create password for those accounts. 
	Link => "https://developer.paypal.com/docs/classic/lifecycle/sb_create-accounts/" 
		 
4. Copy Login,Password and Signature of faciliator account from API credential tab. 

5. Now copy those credentials in config/environments/development.rb 
  config.after_initialize do 
	ActiveMerchant::Billing::Base.mode = :test 
   	paypal_options = { 
    login: "xxxxxxxxxxxxxxxxxx", 
    password: "xxxxxxxxxxxxxxxxxxxx", 
    signature: "xxxxxxxxxxxxxxxxxxxxxxxxx" 
    } 
   ::EXPRESS_GATEWAY =ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options) 
  end 

6. On Index Page of Product add Buy button for Product and redirect it to express_checkout method 
   of  Product controller. 

  Here token is generated for transaction,
  
	  def express 
	    product = Product.find(params[:id]) 
	    response = EXPRESS_GATEWAY.setup_purchase(product.product_price.to_i, 
	      ip: request.remote_ip, 
	      return_url: url_for(:action => 'complete', :id => product.id), 
	      cancel_return_url: "http://localhost:3000/products", 
	      currency: "USD", 
	      allow_guest_checkout: true, 
	      items: [{name: product.product_name, quantity: "1", amount: product.product_price.to_i}] 
	    ) 
	    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token) 
	  end 


Now, Complete method of Product controller is called with params :token and payer_id 

7. Complete method is for purchase product and completing the transaction, 

  def complete 
    product = Product.find(params[:id]) 
    begin 
     purchase = EXPRESS_GATEWAY.purchase(product.product_price, 
            :ip       => request.remote_ip, 
            :payer_id => params[:PayerID], 
            :token    => params[:token] 
        ) 
     puts(purchase) 
    rescue Exception => e 
        logger.error "Paypal error while creating payment: #{e.message}" 
        flash[:error] = e.message 
    end 
    unless purchase.success? 
        flash[:error] = "Unfortunately an error occurred:" + purchase.message 
    else 
        flash[:notice] = "Thank you for your payment" 
    end 
    redirect_to products_path 
  end   

8. Login to faciliator account and check the Activity, if transaction is successfully done then 
	 new transaction is available there. 

	   