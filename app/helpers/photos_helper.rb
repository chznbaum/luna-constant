module PhotosHelper
  def gravatar_helper(user)
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", class: 'media-object img-rounded'
  end

  def photo_status_color(photo)
    'color: #5cb85c' if photo.Approved?
  end
end