class Photo < ApplicationRecord
  validates_presence_of :photo_upload

  mount_uploader :photo_upload
  
  belongs_to :user

  def set_user!(user)
    self.user_id = user.id
    
    self.save!
  end
end
