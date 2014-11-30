class AddIsLoginToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_login, :boolean, default: true
  end
end
