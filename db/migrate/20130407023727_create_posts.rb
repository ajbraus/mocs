class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :desc
      t.string :img_url
      t.string :video_url
      t.string :state
      t.date :happening_on
      t.datetime :starts_at
      t.references :user

      t.timestamps
    end
  end
end
