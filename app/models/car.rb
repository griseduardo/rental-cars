class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  validates :license_plate, :color, :mileage, presence: true
end
