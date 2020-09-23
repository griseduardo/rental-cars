FactoryBot.define do
  factory :car do
    sequence(:license_plate) { |i| "ABC123#{i}" }
    mileage { 1000 }
    color { 'Vermelho' }
    status { :available }
    car_model
    subsidiary
  end
end