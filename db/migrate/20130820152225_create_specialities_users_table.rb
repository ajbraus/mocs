class CreateSpecialitiesUsersTable < ActiveRecord::Migration
  def self.up
    create_table :specialities_users, :id => false do |t|
      t.references :user
      t.references :speciality
    end
    add_index :specialities_users, [:user_id, :speciality_id]
    add_index :specialities_users, [:speciality_id, :user_id]
  end

  def self.down
    drop_table :specialities_users
  end
end