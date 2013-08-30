class AddingCcAndBankNumbersToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_recipient_id, :string
    add_column :users, :stripe_verified, :boolean, default: false
    add_column :users, :stripe_customer_id, :string
    add_column :commitments, :paid, :boolean, default: false
    add_column :commitments, :paid_out, :boolean, default: false
  end
end
