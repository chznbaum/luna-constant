class Comment < ApplicationRecord
  validates_presence_of :body, :user_id

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable
end
