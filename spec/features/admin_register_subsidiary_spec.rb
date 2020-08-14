require 'rails_helper'

feature 'Admin register subsidiaries' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '10.404.931/0001-09'
    fill_in 'Endereço', with: 'Av Paulista, 177'

    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Paulista')
    expect(page).to have_content('10.404.931/0001-09')
    expect(page).to have_content('Av Paulista, 177')
    expect(page).to have_link('Voltar')
  end
end