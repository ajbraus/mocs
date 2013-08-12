class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me, 
                  :name, 
                  :state, 
                  :terms
  # attr_accessible :title, :body

  has_many :posts
  
  has_many :organization_users
  has_many :organizations, through: :organization_users

  has_many :commitments, foreign_key: "committed_user_id", dependent: :destroy
  has_many :committed_tos, through: :commitments, source: :commitment

  has_many :comments, as: :commentable
  has_many :comments 
  
  has_many :messages, class_name: "Message", foreign_key: "receiver_id"
  has_many :read_messages, class_name: "Message", foreign_key: "receiver_id", conditions: { is_read: true }
  has_many :unread_messages, class_name: "Message", foreign_key: "receiver_id", conditions: { is_read: false }
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

  acts_as_voter
  has_karma(:comments)

  #validates :name, presence: true

  before_create :skip_confirmation_notification
  after_create :request_confirmation

  # def send_welcome
  #   Notifier.delay.welcome(self)
  # end

  def request_confirmation
    Notifier.delay.request_confirmation(self)
  end

  def nice_created_at
    created_at.strftime("%b %e, %Y") #May 21, 2010
  end
  
  def nice_name
    @name_array = self.name.split(' ')
    @name_array.each { |n| n.capitalize }
  end

  def name=(s)
    write_attribute(:name, s.to_s.titleize) # The to_s is in case you get nil/non-string
  end

  def first_name
    @name_array = self.name.split(' ')
    @name_array[0].capitalize
  end

  def first_name_with_last_initial
    @name_array = self.name.split(' ')
    @name_array[0].capitalize + " " + @name_array.last.capitalize.slice(0) + "."
  end

  def last_name
    @name_array = self.name.split(' ')
    @name_array.last
  end

  def middle_name
    self.name.split.count > 3 ? self.name.split(' ')[1] : nil
  end
  
  def committed_to?(post)
    return commitments.find_by_commitment_id(post.id).present?
  end
  
  def commit!(post)
    @commitment = commitments.create!(commitment_id: post.id)
  end  

  def reneg!(commitment)
    commitments.find(commitment.id).destroy
  end

  def organization
    organizations.first if organizations.any?
  end

  def organization=(name)
    self.organizations << Organization.find_or_create_by_name(name) unless name.blank?
  end

  def skip_confirmation_notification
    skip_confirmation_notification!
  end

  def balanced_customer
    return Balanced::Customer.find(self.customer_uri) if self.customer_uri

    begin
      customer = self.class.create_balanced_customer(
        :name   => self.name,
        :email  => self.email
        )
    rescue
      'There was error fetching the Balanced customer'
    end

    self.customer_uri = customer.uri
    self.save
    customer
  end

  def self.create_balanced_customer(params = {})
    begin
      Balanced::Marketplace.mine.create_customer(
        :name   => params[:name],
        :email  => params[:email]
        )
    rescue
      'There was an error adding a customer'
    end
  end

  def org_admin?(org)
    return org.organization_users.find(self.id).is_admin?
  end
end
