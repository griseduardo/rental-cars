require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Paulista', cnpj: '18.302.719/0001-18', 
                       address: 'Av Paulista, 177')
    Subsidiary.create!(name: 'Vila Mariana', cnpj: '23.302.776/0001-02', 
                       address: 'Av Sena Madureira, 268')
    Subsidiary.create!(name: 'Vila Leopoldo', cnpj: '83.104.889/0001-11', 
                       address: 'Rua Ananias, 566')

    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Paulista')
    expect(page).to have_content('Av Paulista, 177')
    expect(page).to have_content('Vila Mariana')
    expect(page).to have_content('Av Sena Madureira, 268')
    expect(page).to have_content('Vila Leopoldo')
    expect(page).to have_content('Rua Ananias, 566')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Paulista', cnpj: '18.302.719/0001-18', 
                       address: 'Av Paulista, 177')
    Subsidiary.create!(name: 'Vila Mariana', cnpj: '23.302.776/0001-02', 
                       address: 'Av Sena Madureira, 268')
    Subsidiary.create!(name: 'Vila Leopoldo', cnpj: '83.104.889/0001-11', 
                       address: 'Rua Ananias, 566')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'

    expect(page).to have_content('Paulista')
    expect(page).to have_content('18.302.719/0001-18')
    expect(page).to have_content('Av Paulista, 177')
    expect(page).not_to have_content('Vila Mariana')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Paulista', cnpj: '18.302.719/0001-18', 
                       address: 'Av Paulista, 177')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Paulista', cnpj: '18.302.719/0001-18', 
                       address: 'Av Paulista, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Paulista'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end