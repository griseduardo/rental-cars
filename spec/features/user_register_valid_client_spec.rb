require 'rails_helper'

feature 'Admin register valid client' do
  scenario 'must be logged in to view clients' do
    visit root_path

    expect(page).not_to have_link('Clientes')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    user_login(user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'
    
    expect(Client.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and cpf must be unique' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    Client.create!(name: 'Fulano Sicrano', cpf: '675.623.640-79', 
                   email: 'test@client.com')

    user_login(user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano'
    fill_in 'CPF', with: '675.623.640-79'
    fill_in 'Email', with: 'ful@client.com'
    click_on 'Enviar'
    
    expect(page).to have_content('CPF já está em uso')
  end

  scenario 'and cpf length must be 14' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    user_login(user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano'
    fill_in 'CPF', with: '675.623.40-79'
    fill_in 'Email', with: 'ful@client.com'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('CPF não possui o tamanho esperado (14 caracteres)', count: 1)
  end

  scenario 'and cpf length is 14 but it includes one or more invalid character(s)' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    user_login(user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano'
    fill_in 'CPF', with: '675.623.6*0-79'
    fill_in 'Email', with: 'ful@client.com'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('os caracteres aceitos para CPF são: números(0 a 9), ponto(.) e traço(-)', count: 1)
  end

  scenario 'and cpf is not valid' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    user_login(user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Fulano'
    fill_in 'CPF', with: '123.456.789-10'
    fill_in 'Email', with: 'ful@client.com'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('CPF não é válido', count: 1)
  end
end