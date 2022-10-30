class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_one_attached :photo
  has_many :users
end
