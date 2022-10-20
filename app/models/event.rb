class Event < ApplicationRecord
  has_many :tickets
  has_one_attached :photo
end
