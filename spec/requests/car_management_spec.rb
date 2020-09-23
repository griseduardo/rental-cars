require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                                      address: 'Av Paulista, 177')
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
                                         car_insurance: 100,
                                         third_party_insurance: 100)
      car_model = CarModel.create!(name: 'Onix 1.0', year: 2019, 
                                   manufacturer: 'Chevrolet', fuel_type: 'Flex',
                                   car_category: car_category,
                                   motorization: '1.0')
      Car.create!(license_plate: 'ABC1234', color: 'Vermelho', mileage: 1000,
                  car_model: car_model, subsidiary: subsidiary, status: :available)
      Car.create!(license_plate: 'DCF4356', color: 'Preto', mileage: 1000,
                  car_model: car_model, subsidiary: subsidiary, status: :available)
      Car.create!(license_plate: 'FDSE1234', color: 'Preto', mileage: 1000,
                  car_model: car_model, subsidiary: subsidiary, status: :rented)

      get '/api/v1/cars'

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[0][:license_plate]).to eq('ABC1234')
      expect(body[0][:color]).to eq('Vermelho')
      expect(body[1][:license_plate]).to eq('DCF4356')
      expect(response.body).not_to include('FDSE1234')
    end
  end
end