require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Loccar', cnpj: '18302719472918', 
                       address: 'Rua Evans, 177')
    Subsidiary.create!(name: 'Drivecar', cnpj: '23302776472802', 
                       address: 'Rua Cantagalo, 268')
    Subsidiary.create!(name: 'Lifecar', cnpj: '83104889472111', 
                       address: 'Rua Santo Afonso, 566')

    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Loccar')
    expect(page).to have_content('Drivecar')
    expect(page).to have_content('Lifecar')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Loccar', cnpj: '18302719472918', 
                       address: 'Rua Evans, 177')
    Subsidiary.create!(name: 'Drivecar', cnpj: '23302776472802', 
                       address: 'Rua Cantagalo, 268')
    Subsidiary.create!(name: 'Lifecar', cnpj: '83104889472111', 
                       address: 'Rua Santo Afonso, 566')

    visit root_path
    click_on 'Filiais'
    click_on 'Loccar'

    expect(page).to have_content('Loccar')
    expect(page).to have_content('18302719472918')
    expect(page).to have_content('Rua Evans, 177')
    expect(page).not_to have_content('Drivecar')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Loccar', cnpj: '18302719472918', 
                       address: 'Rua Evans, 177')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Loccar', cnpj: '18302719472918', 
                       address: 'Rua Evans, 177')

    visit root_path
    click_on 'Filiais'
    click_on 'Loccar'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end