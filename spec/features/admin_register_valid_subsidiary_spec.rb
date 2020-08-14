require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and attributes cannot be blank' do
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
    Subsidiary.create!(name: 'Vila Leopoldo', cnpj: '52.172.478/0001-00', 
                       address: 'Rua Ananias, 566')

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
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    fill_in 'Nome', with: 'Vila Leopoldo'
    fill_in 'CNPJ', with: '83.104.89/0001-11'
    fill_in 'Endereço', with: 'Rua Jaí, 10'
    click_on 'Enviar'

    expect(Subsidiary.count).to eq 0
    expect(page).to have_content('não possui o tamanho esperado (18 caracteres)', count: 1)
  end

  scenario 'and cnpj is not valid' do
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