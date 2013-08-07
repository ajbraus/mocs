namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [User, Post, Comment, Tag, Commitment, Goal, Message, Organization, OrganizationUser].each(&:delete_all)
    Organization.create(name:"UW Health")
    Organization.create(name:"Gundersen Lutheran")
    Organization.create(name:"Mayo Clinic")
    Organization.create(name:"Guthrie Health")
    Organization.create(name:"Cleveland Clinic")

    Goal.create(id: 1, name: "Outcomes")
    Goal.create(id: 2, name: "Costs")
    Goal.create(id: 3, name: "Satisfaction")
    Goal.create(id: 4, name: "Process")

    User.populate 20 do |user|
      user.name    = Faker::Name.name
      user.email   = Faker::Internet.email
      user.state = "WI"
      user.encrypted_password = "password"
    end
    adam = User.create(name:"Adam J Braus", email:"ajbraus@gmail.com", password:"password", state:"WI")
    james = User.create(name:"James Lloyd", email:"james.jd.lloyd@gmail.com", password:"password", state:"WI")
    adam.organizations << Organization.find_by_name("UW Health")
    james.organizations << Organization.find_by_name("UW Health")

    User.all.each do |user|
      user.organizations << Organization.all.sample
      Post.populate 10..30 do |post|
        post.title = Populator.words(7..18).titleize
        post.desc = Populator.words(50..120)
        post.user_id = user.id
        post.state = "WI"
        post.duration = 600000..18000000
        post.expected_time = 60000..100000
        post.video_url = "http://www.youtube.com/watch?v=bCGlWQnzDVE"
        post.img_url = "http://img.youtube.com/vi/x10zrYPuU_o/default.jpg"
        post.created_at = 4.months.ago..Time.now
        post.last_touched = 4.months.ago..Time.now
        post.credits = 0..30
        post.impressions_count = 1..3000
        post.published = [true,false]
        if post.published == true
          post.published_at = 4.months.ago..Time.now
        end
        post.begins_on = Time.now..Time.now + 4.months
        post.ends_on = Time.now + 4.months..Time.now + 7.months
        Comment.populate 3..30 do |comment|
          comment.commentable_type = "Post"
          comment.commentable_id = post.id
          comment.content = Populator.words(3..14)
        end
        Message.populate 4..10 do |message|
          message.subject = Populator.words(7..18).titleize
          message.body = Populator.words(50..120)
          message.sender_id = user.id
          message.receiver_id = user.id   #TODO - stop messaging yourself
          message.is_read = [true,false]
        end
      end
    end
    Post.all.each do |post|
      5.times { post.tags << Tag.create(:name => Populator.words(1)) } 
      post.goals << Goal.find(1)
    end

    #rake ts:index
    
    # Person.populate 100 do |person|
    #   person.name    = Faker::Name.name
    #   person.company = Faker::Company.name
    #   person.email   = Faker::Internet.email
    #   person.phone   = Faker::PhoneNumber.phone_number
    #   person.street  = Faker::Address.street_address
    #   person.city    = Faker::Address.city
    #   person.state   = Faker::Address.us_state_abbr
    #   person.zip     = Faker::Address.zip_code
    # end
  end
end