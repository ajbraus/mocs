FactoryGirl.define do
  factory :organization do
    name 'UW Heatlh'
  end

  factory :user do
    sequence(:name)  { |n| "Test User #{n}" }
    sequence(:email) { |n| "test@#{n}.com"} 
    password "password"
    reset_password_token ""
    reset_password_sent_at ""
    remember_created_at ""
    sign_in_count ""
    current_sign_in_at ""
    last_sign_in_at ""
    current_sign_in_ip ""
    last_sign_in_ip ""
    created_at ""
    updated_at ""
    terms ""
    admin ""
    rejected_at ""
    deleted ""
    credits ""
    confirmation_token ""
    confirmed_at ""
    confirmation_sent_at ""
  end

  factory :post do
    sequence(:title)  { |n| "Test Post #{n}" }
    desc ""
    img_url ""
    video_url ""
    begins_on ""
    ends_on ""
    price ""
    published ""
    published_at ""
    user_id ""
    created_at ""
    updated_at ""
    impressions_count ""
    last_touched ""
    state ""
    credits ""
    expected_time ""
    actual_time ""
    duration ""
    info ""
    baseline ""
    plan_do ""
    post_test ""
    wrap_up ""
    organization_id ""
    goal_id ""
  end
end