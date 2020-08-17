require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Editar'
    fill_in 'Nome', with: 'Vila Esperança'
    fill_in 'CNPJ', with: '78.134.335/0001-90'
    fill_in 'Endereço', with: 'Rua Evans, 47'
    click_on 'Enviar'

    expect(page).to have_content('Vila Esperança')
    expect(page).not_to have_content('Paulista')
    expect(page).to have_content('78.134.335/0001-90')
    expect(page).to have_content('Rua Evans, 47')
  end

  scenario 'and attributes cannot be blank' do
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and cnpj must be unique' do
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')
    Subsidiary.create!(name: 'Vila Leopoldo', cnpj: '52.172.478/0001-00', 
                       address: 'Rua Ananias, 566')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '52.172.478/0001-00'
    fill_in 'Endereço', with: 'Av Paulista, 177'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and cnpj length must be 18' do
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '10.404.931/0001'
    fill_in 'Endereço', with: 'Av Paulista, 177'
    click_on 'Enviar'

    expect(page).to have_content('não possui o tamanho esperado (18 caracteres)', count: 1)
  end

  scenario 'and cnpj length is 18 but it includes one or more invalid character(s)' do
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '52.172*478/0001w00'
    fill_in 'Endereço', with: 'Av Paulista, 177'
    click_on 'Enviar'

    expect(page).to have_content('os caracteres aceitos são: números(0 a 9), ponto(.), barra(/) e traço(-)', count: 1)
  end

  scenario 'and cnpj is not valid' do
    Subsidiary.create!(name: 'Paulista', cnpj: '10.404.931/0001-09', 
                       address: 'Av Paulista, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '83.104.891/0201-11'
    fill_in 'Endereço', with: 'Av Paulista, 177'
    click_on 'Enviar'

    expect(page).to have_content('não é válido', count: 1)
  end
end