class Ticket < ApplicationRecord
  enum status: { "Open" => 0, "In Progress" => 1, "Closed" => 2 }

  validates :title, presence: true, length: { minimum: 5 }

  belongs_to :user
  has_many :ticket_messages, dependent: :destroy
  accepts_nested_attributes_for :ticket_messages, allow_destroy: true, reject_if: lambda { |attrs| attrs['message'].blank? } 
end
