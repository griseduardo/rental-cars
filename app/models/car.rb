class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_many :car_rentals
  validates :license_plate, :color, :mileage, presence: true
  validates :license_plate, uniqueness: true
  validates :mileage, numericality: {:greater_than_or_equal_to => 0}

  enum status: { available: 0, rented: 10 }

  def description
    "#{car_model.name} - #{color} - #{license_plate}"
  end
end