class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
  
  validates_presence_of :name
  
  has_many :invitations, :class_name => :user, :as => :invited_by
  has_many :photos, dependent: :destroy

  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end
end
