class CreateSpecialitiesPostsTable < ActiveRecord::Migration
  def self.up
    create_table :posts_specialities, :id => false do |t|
      t.references :post
      t.references :speciality
    end
    add_index :posts_specialities, [:post_id, :speciality_id]
    add_index :posts_specialities, [:speciality_id, :post_id]
  end

  def self.down
    drop_table :posts_specialities
  end
end