class AddTosToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :tos, :boolean
  end
end
