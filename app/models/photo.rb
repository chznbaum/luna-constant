class Photo < ApplicationRecord
  validates_presence_of :photo_upload, :status

  enum status: { "Pending" => 0, "Approved" => 1 }

  mount_uploader :photo_upload
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  def set_user!(user)
    self.user_id = user.id
    
    self.save!
  end

  def self.by_recent
    order("created_at DESC")
  end
end
