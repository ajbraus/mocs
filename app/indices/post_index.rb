ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes :title, as: :post_title
  indexes :desc, as: :description
  indexes tags(:name), as: :tag_name
  # indexes organizations(:name), as: :org_name
  indexes user(:name), as: :author_name
  # indexes happening_on, sortable: true
  # has author_id, published_at
  has published_at
  has last_touched
  has state
  has published

  set_property:field_weights => {
    :post_title => 5,
    :description => 1,
    :tag_name => 10,
    :org_name => 10,
    :author_name => 10
  }
end