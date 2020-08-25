require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'must be logged in to view categories' do
    visit root_path

    expect(page).not_to have_link('Categorias')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
                        
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do carro', with: ''
    fill_in 'Seguro para terceiros', with: ''
    click_on 'Enviar'
    
    expect(CarCategory.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
 
  scenario 'and name must be unique' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and daily rate, car insurance and third party insurance must not be negative' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
    password: '12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: -10
    fill_in 'Seguro do carro', with: -50
    fill_in 'Seguro para terceiros', with: -30
    click_on 'Enviar'

    expect(page).to have_content('Diária deve ser maior ou igual a 0')
    expect(page).to have_content('Seguro do carro deve ser maior ou igual a 0')
    expect(page).to have_content('Seguro para terceiros deve ser maior ou igual a 0')
  end
end
