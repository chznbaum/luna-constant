class Photo < ApplicationRecord
  validates_presence_of :photo_upload

  mount_uploader :photo_upload
  
  belongs_to :user
end
