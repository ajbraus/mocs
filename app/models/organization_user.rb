class OrganizationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  attr_accessible :is_admin
end
