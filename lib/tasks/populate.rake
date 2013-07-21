namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User, Post, Comment, Tag].each(&:delete_all)
    
    User.populate 20 do |user|
      user.name    = Faker::Name.name
      user.email   = Faker::Internet.email
      user.state = "WI"
      user.encrypted_password = "password"
    end
    User.create(name:"Adam J Braus", email:"ajbraus@gmail.com", password:"password", state:"WI")
    User.create(name:"James Lloyd", email:"james.jd.lloyd@gmail.com", password:"password", state:"WI")
    User.all.each do |user|
      Post.populate 10..30 do |post|
        post.title = Populator.words(7..18).titleize
        post.desc = Populator.words(50..120)
        post.user_id = user.id
        post.state = "WI"
        post.video_url = "http://www.youtube.com/watch?v=bCGlWQnzDVE"
        post.img_url = "http://img.youtube.com/vi/x10zrYPuU_o/default.jpg"
        post.created_at = 4.months.ago..Time.now
        post.last_touched = 4.months.ago..Time.now
        post.impressions_count = 1..50000
        post.published = [true,false]
        if post.published == true
          post.published_on = 4.months.ago..Time.now
        end
        Comment.populate 3..30 do |comment|
          comment.commentable_type = "Post"
          comment.commentable_id = post.id
          comment.content = Populator.words(3..14)
        end
      end
    end
    Post.all.each do |post|
      5.times { post.tags << Tag.create(:name => Populator.words(1)) } 
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