class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  validates :license_plate, :color, :mileage, presence: true
  validates :license_plate, uniqueness: true

  validate :mileage_must_not_be_negative

  private

  def mileage_must_not_be_negative
    return if mileage.blank?
    return if mileage >= 0
    errors.add(:mileage, 'Quilometragem não pode ser negativa')
  end
end
