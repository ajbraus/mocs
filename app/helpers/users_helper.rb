module UsersHelper
  def us_states
    [
      ['AL'],
      ['AK'],
      ['AZ'],
      ['AR'],
      ['CA'],
      ['CO'],
      ['CT'],
      ['DE'],
      ['DC'],
      ['FL'],
      ['GA'],
      ['HI'],
      ['ID'],
      ['IL'],
      ['IN'],
      ['IA'],
      ['KS'],
      ['KY'],
      ['LA'],
      ['ME'],
      ['MD'],
      ['MA'],
      ['MI'],
      ['MN'],
      ['MS'],
      ['MO'],
      ['MT'],
      ['NE'],
      ['NV'],
      ['NH'],
      ['NJ'],
      ['NM'],
      ['NY'],
      ['NC'],
      ['ND'],
      ['OH'],
      ['OK'],
      ['OR'],
      ['PA'],
      ['PR'],
      ['RI'],
      ['SC'],
      ['SD'],
      ['TN'],
      ['TX'],
      ['UT'],
      ['VT'],
      ['VA'],
      ['WA'],
      ['WV'],
      ['WI'],
      ['WY']
    ]
  end

  def profile_picture(user)
    if user.avatar.present?
      image_tag user.avatar.url(:medium), class:"medium-thumbnail img-rounded"
    else
      image_tag "default_profile_pic.png", class:"medium-thumbnail img-rounded"
    end
  end

  def small_profile_picture(user)
    if user.avatar.present?
      image_tag user.avatar.url(:thumb), class:"small-thumbnail img-rounded"
    else
      image_tag "default_profile_pic.png", class:"small-thumbnail img-rounded"
    end
  end


  def large_profile_picture(user)
    if user.avatar.present?
      image_tag user.avatar.url(:medium), class:"large-thumbnail img-rounded"
    else
      image_tag "default_profile_pic.png", class:"large-thumbnail img-rounded"
    end
  end
end