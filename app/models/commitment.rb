class Commitment < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :commitment_id
  
  belongs_to :committed_user, class_name: "User"
  belongs_to :commitment, class_name: "Post"

  validates :committed_user_id, presence: true
  validates :commitment_id, presence: true    
  
  def nice_created_at_date
    created_at.strftime("%b %e, %Y") #May 21, 2010
  end

  def nice_created_at
    created_at.strftime("%l:%M%p %b %e, %y") #May 21, 10
  end

  def percent_complete
    if progress == 6
      return 100
    else
      return progress*17
    end
  end
end