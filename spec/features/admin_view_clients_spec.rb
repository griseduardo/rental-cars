require 'rails_helper'

feature 'Admin view clients' do
  scenario 'must be logged in to view clients' do
    visit root_path

    expect(page).not_to have_link('Clientes')
  end

  scenario 'must be logged in to view clients list' do
    visit clients_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view client details' do
    client = Client.create!(name: 'Fulano Sicrano', cpf: '675.623.640-79', 
                            email: 'test@client.com')

    visit client_path(client)

    expect(current_path).to eq new_user_session_path
  end
end