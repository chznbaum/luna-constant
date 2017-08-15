class TicketMessage < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :message, presence: true, length: { minimum: 1 }
end
