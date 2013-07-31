class Organization < ActiveRecord::Base
  attr_accessible :name

  has_many :organization_users
  has_many :users, through: :organization_users
  has_many :admins, through: :organization_users, class_name: "User", source: :user, conditions: ['organization_users.is_admin = ?', true]
end
