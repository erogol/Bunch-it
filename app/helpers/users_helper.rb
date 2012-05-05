module UsersHelper
  def gravatar_for(user, options = { :size => 80 })
    gravatar_image_tag(user.email.downcase, :alt => user.user_name,
                                            :class => 'gravatar round',
                                            :gravatar => options)
  end
end
