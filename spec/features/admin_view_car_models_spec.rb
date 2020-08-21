require 'rails_helper'

feature 'Admin view car model' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  scenario 'and view list' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                     motorization: '1.0', car_category: car_category, 
                     fuel_type: 'Flex')
    CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet',
                     motorization: '1.0', car_category: car_category,
                     fuel_type: 'Flex')

    user_login(user)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Ka')
    expect(page).to have_content('Ford')
    expect(page).to have_content('2019')
    expect(page).to have_content('Onix')
    expect(page).to have_content('2020')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Top', count: 2)
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and view details' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                     motorization: '1.0', car_category: car_category, 
                     fuel_type: 'Flex')
    CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet',
                     motorization: '1.0', car_category: car_category,
                     fuel_type: 'Flex')

    user_login(user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka - 2019'

    expect(page).to have_content('Ka')
    expect(page).to have_content('2019')
    expect(page).to have_content('Ford')
    expect(page).to have_content('1.0')
    expect(page).to have_content(car_category.name)
    expect(page).to have_content('Flex')
    expect(page).not_to have_content('Onix')
    expect(page).not_to have_content('Chevrolet')
    expect(page).to have_link('Voltar', href: car_models_path)
  end

  scenario 'and nothing is registered' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    user_login(user)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end
end