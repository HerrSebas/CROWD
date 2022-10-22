class Event < ApplicationRecord
  has_many :tickets
  has_one_attached :photo
  has_many :users
end
