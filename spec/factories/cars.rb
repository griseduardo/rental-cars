FactoryBot.define do
  factory :car do
    license_plate { 'ABC1234' }
    mileage { 1000 }
    color { 'Vermelho' }
    status { :available }
    car_model
  end
end