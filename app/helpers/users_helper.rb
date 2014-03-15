module UsersHelper
  
  def recieved(in_id)
    don = Donation.where(user_id: in_id, approved: true)
    
    unless don.empty?
      don.sum(:amount).to_s
    else
      ''
    end
  end
  
  def donated(in_id)
    user = User.find(in_id)
    
    unless user.nil?
      user.donated.to_s
    else
      0.0
    end
  end
  
  # => Emits the tag for a user's gravatar
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=100"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end
  
  def profile_image(user_id)
    image_tag url_for controller: 'users', action: 'get_user_image', type: 'image/jpeg', id: user_id
  end
  
  def profile_image_small(user_id)
    ('<img src="' + image_url(user_id) + '" style="height: 60px;">').html_safe
  end
  
  def image_url(user_id)
    url_for controller: 'users', action: 'get_user_image', type: 'image/jpeg', id: user_id
  end
      
end
