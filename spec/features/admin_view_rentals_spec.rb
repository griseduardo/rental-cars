require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'must be logged in to view rentals' do
    visit root_path

    expect(page).not_to have_link('Locações')
  end

  scenario 'and view list' do
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com',
                            cpf: '893.203.383-88')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 100, 
                                       car_insurance: 100, third_party_insurance: 100)
    user = User.create!(email: 'user@test.com', password: '12345678', 
                        name: 'Sicrano Fulano')
    Rental.create!(start_date: '03/04/2100', end_date: '06/04/2100',
                   client: client, car_category: car_category, 
                   user: user)
    Rental.create!(start_date: '04/08/2102', end_date: '06/08/2102',
                   client: client, car_category: car_category, 
                   user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
               
    expect(page).to have_content('03/04/2100')
    expect(page).to have_content('06/04/2100')
    expect(page).to have_content('04/08/2102')
    expect(page).to have_content('06/08/2102')
    expect(page).to have_content('Fulano Sicrano', count: 2)
    expect(page).to have_content('893.203.383-88', count: 2)
    expect(page).to have_content('client@test.com', count: 2)
    expect(page).to have_content('Top', count: 2)
    expect(page).to have_content('900')
    expect(page).to have_content('600')
    expect(page).to have_content('user@test.com', count: 2)
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and nothing is registered' do
    user = User.create!(email: 'user@test.com', password: '12345678', 
                        name: 'Sicrano Fulano')

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Nenhuma locação agendada')
  end
  
  scenario 'must be logged in to view rental list' do
    visit rentals_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view rental details' do
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100,
                                       third_party_insurance: 100)
    client = Client.create!(name: 'Fulano Sicrano', cpf: '512.129.580-47',
                            email: 'test@client.com')
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                            client: client, user: user, car_category: car_category)
   
    visit rental_path(rental)

    expect(current_path).to eq new_user_session_path
  end
end