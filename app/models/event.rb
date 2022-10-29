class Event < ApplicationRecord
  has_many :tickets
  has_one_attached :photo
  has_many :users
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
