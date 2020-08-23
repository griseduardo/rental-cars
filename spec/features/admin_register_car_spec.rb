require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                     motorization: '1.0', car_category: car_category, 
                     fuel_type: 'Flex')
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar carro para frota'
    fill_in 'Placa', with: 'MYL-5593'
    fill_in 'Cor', with: 'Preto'
    select 'Ka - 2019', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: 80
    select 'Paulista', from: 'Filial'
    click_on 'Enviar'
    
    expect(page).to have_content('MYL-5593')
    expect(page).to have_content('Preto')
    expect(page).to have_content('Ka')
    expect(page).to have_content('2019')
    expect(page).to have_content('Ford')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
    expect(page).to have_content('80')
    expect(page).to have_content('Paulista')
    expect(page).to have_content('10.404.931/0001-09')
    expect(page).to have_content('Av Paulista, 177')
    expect(page).to have_content('Cadastro realizado com sucesso!')
  end

  scenario 'must fill in all fields' do
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
    password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar carro para frota'
    click_on 'Enviar'

    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Modelo de carro é obrigatório(a)')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
    expect(page).to have_content('Filial é obrigatório(a)')
  end

  scenario 'must be logged in to register car' do
    visit new_car_path

    expect(current_path).to eq new_user_session_path
  end
end