require 'rails_helper'

feature 'Admin register subsidiaries' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  scenario 'successfully' do
    user = User.create!(name: 'João Almeida', email: 'joao@email.com', 
                        password: '12345678')
    
    user_login(user)
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