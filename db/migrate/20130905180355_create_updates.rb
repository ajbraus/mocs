class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :subject
      t.text :body
      t.references :post

      t.timestamps
    end
    add_index :updates, :post_id
  end
end
