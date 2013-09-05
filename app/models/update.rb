class Update < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :subject
end
