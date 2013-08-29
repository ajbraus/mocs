class AddingCcAndBankNumbersToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_recipient_id, :string
    add_column :users, :stripe_customer_id, :string
    add_column :commitments, :paid, :boolean, default: false
  end
end
