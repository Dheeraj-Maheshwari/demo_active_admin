class AddAvatarToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :avatar, :string
  end
end
