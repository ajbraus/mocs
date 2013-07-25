class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :desc
      t.string :img_url
      t.string :video_url
      t.datetime :begins_on
      t.datetime :ends_on
      t.integer :price
      t.boolean :certified
      t.boolean :published, default: false
      t.datetime :published_at
      t.references :user

      t.timestamps
    end
  end
end
