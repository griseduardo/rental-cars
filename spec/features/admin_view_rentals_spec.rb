require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'must be logged in to view rentals' do
    visit root_path

    expect(page).not_to have_link('Locações')
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