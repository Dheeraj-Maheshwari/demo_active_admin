class Product < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	 def paypal_url(return_url)

values = {
:business => email,
:cmd => '_cart',
:upload => 1,
:return => return_url,
#:invoice => UNIQUE_INTEGER
}

values.merge!({
"amount_1" => price,
"item_name_1" => name ,
"item_number_1" => id,
"quantity_1" => '1'
})

"https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
end
end
