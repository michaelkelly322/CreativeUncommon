module UsersHelper
  
  # => Emits the tag for a user's gravatar
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=100"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end
  
  # => Emits the tag for a user's profile image
  # => Is only valid in locations where the user's id
  # => is gaurenteed as part of the request
  def profile_image
    image_tag url_for controller: 'users', action: 'get_user_image', type: 'image/jpeg'
  end
end
