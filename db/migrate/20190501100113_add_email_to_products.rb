class AddEmailToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :email, :string
  end
end
