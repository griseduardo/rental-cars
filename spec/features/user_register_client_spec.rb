require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano Sicrano'
    fill_in 'CPF', with: '675.623.640-79'
    fill_in 'Email', with: 'test@client.com'
    click_on 'Enviar'

    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('675.623.640-79')
    expect(page).to have_content('test@client.com')
    expect(page).to have_content('Cliente cadastrado com sucesso')
  end

  scenario 'must fill in all fields' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  scenario 'must be logged in to register client' do
    visit new_client_path

    expect(current_path).to eq new_user_session_path
  end
end