class AddRegistrationUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :registration_url, :string
  end
end
