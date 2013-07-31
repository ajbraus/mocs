class CreateOrganizationUsers < ActiveRecord::Migration
  def self.up
    create_table :organization_users, :id => false do |t|
      t.boolean :is_admin, default: false
      t.references :user
      t.references :organization
    end
    add_index :organization_users, [:user_id, :organization_id]
    add_index :organization_users, [:organization_id, :user_id]
  end

  def self.down
    drop_table :organization_users
  end
end