ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes :title, as: :post_title
  indexes :desc, as: :description
  #indexes specialities.name, as: :speciality_name
  indexes organization.name, as: :org_name
  indexes user.name, as: :author_name

  has goal.id, as: :goal_id
  has organization.id, as: :org_id
  has specialities(:id), :as => :speciality_ids
  has published_at
  has last_touched
  has published
  has price
  has duration
  has expected_time
  has credits

  set_property:field_weights => {
    :post_title => 5,
    :description => 1,
    #:speciality_name => 5,
    :org_name => 10,
    :author_name => 10
  }
end