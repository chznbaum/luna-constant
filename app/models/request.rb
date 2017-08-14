class Request
  include ActiveModel::Model
  attr_accessor :name, :email, :how_they_know
  validates :name, :email, :how_they_know, presence: true
end