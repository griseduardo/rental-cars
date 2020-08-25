require 'rails_helper'

feature 'Admin register valid car' do
  scenario 'must be signed in' do
    visit root_path

    expect(page).not_to have_link('Carros')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar carro para frota'
    click_on 'Enviar'

    expect(Car.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('é obrigatório(a)', count: 2)
  end

  scenario 'and license plate must be unique' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                                 motorization: '1.0', car_category: car_category, 
                                 fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                                    address: 'Av Paulista, 177')
    Car.create!(license_plate: 'MYL-5593', color: 'Preto', car_model: car_model,
                mileage: 80, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar carro para frota'
    fill_in 'Placa', with: 'MYL-5593'
    fill_in 'Cor', with: 'Azul'
    select 'Ka - 2019', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: 60
    select 'Paulista', from: 'Filial'
    click_on 'Enviar'
            
    expect(page).to have_content('Placa já está em uso')
  end

  scenario 'and mileage must not be negative' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                                 motorization: '1.0', car_category: car_category, 
                                 fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                                    address: 'Av Paulista, 177')

    login_as user, scope: :user
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar carro para frota'
    fill_in 'Placa', with: 'MYL-5593'
    fill_in 'Cor', with: 'Preto'
    select 'Ka - 2019', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: -10
    select 'Paulista', from: 'Filial'
    click_on 'Enviar'

    expect(Car.count).to eq 0
    expect(page).to have_content('Quilometragem deve ser maior ou igual a 0', count: 1)
  end
end