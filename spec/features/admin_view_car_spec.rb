require 'rails_helper'

feature 'Admin view cars' do
  scenario 'must be logged in to view cars' do
    visit root_path

    expect(page).not_to have_link('Carros')
  end

  scenario 'must be logged in to view car list' do
    visit cars_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view car details' do
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                                 motorization: '1.0', car_category: car_category, 
                                 fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                                    address: 'Av Paulista, 177')
    car = Car.create!(license_plate: 'MYL-5593', color: 'Preto', car_model: car_model,
                      mileage: 80, subsidiary: subsidiary)

    visit car_path(car)

    expect(current_path).to eq new_user_session_path
  end
end