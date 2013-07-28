class Message < ActiveRecord::Base
  attr_accessible :body, :is_read, :receiver_id, :sender_id, :title

  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"



end
