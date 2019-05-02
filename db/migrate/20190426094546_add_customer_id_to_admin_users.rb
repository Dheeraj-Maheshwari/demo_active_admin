class AddCustomerIdToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :customer_id, :integer
  end
end
