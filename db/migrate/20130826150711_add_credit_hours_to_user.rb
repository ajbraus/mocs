class AddCreditHoursToUser < ActiveRecord::Migration
  def change
    drop_table :tags
    add_column :users, :credit_hours, :integer, default: 1
  end
end
