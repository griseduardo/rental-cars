require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    
    user_login(user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and cnpj must be unique' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    Subsidiary.create!(name: 'Vila Leopoldo', cnpj: '52.172.478/0001-00', 
                       address: 'Rua Ananias, 566')

    user_login(user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Vila Leopoldo'
    fill_in 'CNPJ', with: '52.172.478/0001-00'
    fill_in 'Endereço', with: 'Rua Jaí, 10'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and cnpj length must be 18' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    
    user_login(user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Vila Leopoldo'
    fill_in 'CNPJ', with: '52.172.47/0001-00'
    fill_in 'Endereço', with: 'Rua Jaí, 10'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('não possui o tamanho esperado (18 caracteres)', count: 1)
  end

  scenario 'and cnpj length is 18 but it includes one or more invalid character(s)' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    
    user_login(user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Vila Leopoldo'
    fill_in 'CNPJ', with: '52.172*478/0001w00'
    fill_in 'Endereço', with: 'Rua Jaí, 10'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('os caracteres aceitos são: números(0 a 9), ponto(.), barra(/) e traço(-)', count: 1)
  end

  scenario 'and cnpj is not valid' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')

    user_login(user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Vila Leopoldo'
    fill_in 'CNPJ', with: '83.104.891/0201-11'
    fill_in 'Endereço', with: 'Rua Jaí, 10'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('não é válido', count: 1)
  end
end