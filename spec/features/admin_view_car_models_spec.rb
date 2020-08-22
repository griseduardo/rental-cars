require 'rails_helper'

feature 'Admin view car model' do
  scenario 'must be logged in to view car models' do
    visit root_path

    expect(page).not_to have_link('Modelos de carro')
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

  scenario 'must be logged in to view car models list' do
    visit car_models_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view car models details' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    ka = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', 
                     motorization: '1.0', car_category: car_category, 
                     fuel_type: 'Flex')

    visit car_model_path(ka)

    expect(current_path).to eq new_user_session_path
  end
end