require 'rails_helper'

feature 'Admin deletes car category' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  scenario 'successfully' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    user_login(user)
    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and keep anothers' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    user_login(user)
    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Top')
    expect(page).to have_content('Flex')
  end
end
