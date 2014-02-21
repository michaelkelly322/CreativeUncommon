module UsersHelper
  
  # => Emits the tag for a user's gravatar
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=100"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end
end
