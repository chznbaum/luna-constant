class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:site_admin, :helper], multiple: false)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
  
  validates_presence_of :name
  
  has_many :invitations, :class_name => :user, :as => :invited_by
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end
end
