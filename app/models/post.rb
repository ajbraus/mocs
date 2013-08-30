class Post < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :desc, 
                  :price_in_dollars,
                  :price,
                  :credits,
                  :duration,
                  :expected_time,
                  :state, 
                  :published,
                  :published_at,
                  :begins_on,
                  :ends_on, 
                  :title, 
                  :video_url, 
                  :img_url, 
                  :goal_id,
                  :info, 
                  :baseline, 
                  :plan_do, 
                  :post_test, 
                  :wrap_up,
                  :speciality_ids

  is_impressionable :counter_cache => true #@post.impressions_count
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :user
  belongs_to :goal
  belongs_to :organization
  
  has_many :commitments, foreign_key: :commitment_id, dependent: :destroy
  has_many :committed_users, through: :commitments, source: :committed_user
  
  has_and_belongs_to_many :specialities

  has_many :comments, as: :commentable


  validates :title, presence: true

  def nice_created_at_date
    created_at.strftime("%b %e, %y") #May 21, 2010
  end

  def nice_ends_on
    ends_on.strftime("%b %e %Y") if ends_on.present? #May 21, 2010 
  end

  def nice_begins_on
    begins_on.strftime("%b %e %Y") if begins_on.present? #May 21, 2010 
  end

  def price_in_dollars
    (price.to_d / 100).to_i if price
  end
  
  def price_in_dollars=(dollars)
    self.price = dollars.to_d * 100 if dollars.present?
  end

  def short_desc
    if self.desc.size >=130
      self.desc.slice(0..130) + ". . . "
    else
      self.desc
    end
  end

  def short_title
    if self.title.size >= 40
      self.title.slice(0..40) + "..."
    else
      self.title
    end
  end

  def very_short_desc
    if self.desc.size >=60
      self.desc.slice(0..60) + ". . . "
    else
      self.desc
    end
  end

  # def self.tagged_with(name)
  #   Tag.find_by_name!(name).posts
  # end

  # def self.tag_counts
  #   Tag.select("tags.*, count(taggings.tag_id) as count").
  #     joins(:taggings).group("taggings.tag_id")
  # end

  # def tag_list
  #   tags.map(&:name).join(", ")
  # end

  # def tag_list=(names)
  #   self.tags = names.split(",").map do |n|
  #     Tag.where(name: n.strip).first_or_create!
  #   end
  # end

  def is_committed_to_by?(user)
    return self.committed_user.find_by_committed_user_id(user.id).present?
  end

  # def duration
  #   read_attribute(:duration)/604800
  # end

  # def duration=(val)
  #   write_attribute :duration, val.to_i*604800
  # end

  # def expected_time
  #   read_attribute(:expected_time)/3600
  # end

  # def expected_time_in_words=(val)
  #   write_attribute :expected_time, val.to_i*3600
  # end

  def new?
    if created_at > Time.now - 1.month
      return true
    end
  end
end
