class CarRental < ApplicationRecord
  belongs_to :rental
  belongs_to :car
  belongs_to :user
end

# Controller
# def finish
#   @car_rental.end_date = Date.current
#   @car_rental.total = @car_rental.calculate_final_value
#   @car_rental.save
#   redirect_to @car_rental.rental
# end

# link_to 'Finalizar locação', finish_car_rental_path(@car_rental), method: :post
