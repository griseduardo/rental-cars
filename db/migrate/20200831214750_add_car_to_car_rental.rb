class AddCarToCarRental < ActiveRecord::Migration[6.0]
  def change
    add_reference :car_rentals, :car, null: false, foreign_key: true
  end
end
