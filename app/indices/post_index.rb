ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes :title, as: :post_title
  indexes :desc, as: :description
  indexes tags(:name), as: :tag_name
  indexes organizations(:name), as: :org_name
  indexes user(:name), as: :author_name

  has goals.id, as: :goal_id
  has published_at
  has last_touched
  has published
  has price

  set_property:field_weights => {
    :post_title => 5,
    :description => 1,
    :tag_name => 10,
    :org_name => 10,
    :author_name => 10
  }
end