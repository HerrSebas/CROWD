class Event < ApplicationRecord
  has_many :tickets
  has_one_attached :photo
  belongs_to :order
  has_many :users
end
