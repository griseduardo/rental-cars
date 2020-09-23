FactoryBot.define do
  factory :car_model do
    name { 'Uni 1.0' }
    year { 2019 }
    manufacturer { 'Fiat' }
    motorization { '1.0' }
    fuel_type { 'Flex' }
    car_category
  end
end