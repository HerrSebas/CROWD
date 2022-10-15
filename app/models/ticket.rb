class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :order
end
