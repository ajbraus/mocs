class Post < ActiveRecord::Base
  include PublicActivity::Common
  is_impressionable :counter_cache => true #@post.impressions_count
  #tracked owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :user
  has_many :commitments, foreign_key: :committed_user_id, dependent: :destroy
  has_many :committed_users, through: :commitments
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
  attr_accessible :desc, 
                  :price,
                  :credits,
                  :duration,
                  :expected_time,
                  :goal,
                  :state, 
                  :published,
                  :published_at,
                  :begins_on,
                  :ends_on, 
                  :title, 
                  :video_url, 
                  :img_url, 
                  :tag_list

  validates :title, presence: true

  def nice_created_at_date
    created_at.strftime("%b %e, %y") #May 21, 2010
  end

  def nice_ends_on
    ends_on.strftime("%b %e, %y") if ends_on.present? #May 21, 2010 
  end

  def nice_begins_on
    begins_on.strftime("%b %e, %y") if begins_on.present? #May 21, 2010 
  end

  def short_desc
    if self.desc.size >=180
      self.desc.slice(0..180) + ". . . "
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

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def is_committed_to_by?(user)
    return self.committed_user.find_by_committed_user_id(user.id).present?
  end

  def duration
    read_attribute(:duration)/604800
  end

  def duration=(val)
    write_attribute :duration, val.to_i*604800
  end

  def expected_time
    read_attribute(:expected_time)/3600
  end

  def expected_time_in_words=(val)
    write_attribute :expected_time, val.to_i*3600
  end

end
