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
                  :terms,
                  :confirmed_at,
                  :admin,
                  :organization_ids,
                  :speciality_ids,
                  :avatar

  has_many :posts

  has_many :credit_cards

  has_and_belongs_to_many :specialities
  
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

  has_attached_file :avatar,
         :styles => { 
            :medium => "300x300",
            :thumb => "100x100#" 
            },
         :convert_options => { 
            :thumb => '-quality 60 -strip' 
            },
         :storage => :s3,
         :s3_credentials => { :access_key_id => ENV['S3_ACCESS_KEY'], :secret_access_key => ENV['S3_SECRET_KEY'], :bucket => "bankmybiz"},
         :path => "user_avatars/:id/avatar.:extension",
         :default_url => "https://s3.amazonaws.com/mocsfordocs/default_avatar.png"

  validates :avatar, # :attachment_presence => true,
                     :attachment_content_type => { :content_type => [ 'image/png', 'image/jpg', 'image/gif', 'image/jpeg' ] }

  validates :name, :organizations, :state, :specialities, presence: true

  before_create :skip_confirmation_notification
  after_create :request_confirmation

  # def send_welcome
  #   Notifier.delay.welcome(self)
  # end

  def request_confirmation
    Notifier.delay.internal_new_user(self)
    Notifier.delay.confirmation_of_request(self)
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

  def square_up
    # MINIMIZE THE NUMBER OF TRANSFERS
    mocs_total = 0

    User.where("stripe_recipient_id IS NOT NULL").each do |u|
      @owed_posts = u.posts.joins(:commitments).where(commitments: { paid_out: false })
      if @owed_posts.any?
        total = 0
        @owed_posts.each do |op|
          subtotal = op.commitments.where(paid_out: false).inject {|sum, c| sum + c.price }  
          total = total + subtotal
          op.commitments.each do |c|
            c.paid_out = true
            c.save
          end
        end
        payout = total * 0.67
        transfer = Stripe::Transfer.create(
          :amount => payout,
          :currency => "usd",
          :recipient => u.stripe_recipient_id,
          :statement_descriptor => "MocsforDocs.org - #{c.post.user.name}: #{c.post.title}"
        )
        if transfer.true
          Notifier.delay.payout_receipt(u, @owed_posts, total, payout)
        else
          Notifier.delay.error_payout(u)
        end

        mocs_total = mocs_total + total * 0.33 # COUNT UP THE MOCSFORDOCS TOTAL
      end
      transfer = Stripe::Transfer.create(
        :amount => mocs_total,
        :currency => "usd",
        :recipient => "self",
        :statement_descriptor => "Payout - #{Time.now.strftime("%H:%M %b %e %Y")}"
      )
    end
  end
end
