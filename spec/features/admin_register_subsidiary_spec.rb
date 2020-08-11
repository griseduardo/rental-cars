require 'rails_helper'

feature 'Admin register subsidiaries' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Loccar'
    fill_in 'CNPJ', with: '18302719472918'
    fill_in 'Endereço', with: 'Rua Evans, 177'

    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Loccar')
    expect(page).to have_content('18302719472918')
    expect(page).to have_content('Rua Evans, 177')
    expect(page).to have_link('Voltar')
  end
end