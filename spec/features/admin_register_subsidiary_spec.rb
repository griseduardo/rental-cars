require 'rails_helper'

feature 'Admin register subsidiaries' do
  scenario 'must be signed in' do
    visit root_path

    expect(page).not_to have_link('Filiais')
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
    expect(page).to have_content('Filial criada com sucesso!')
    expect(page).to have_content('Paulista')
    expect(page).to have_content('10.404.931/0001-09')
    expect(page).to have_content('Av Paulista, 177')
    expect(page).to have_link('Voltar')
  end

  scenario 'must be logged in to register new subsidiary' do
    visit new_subsidiary_path

    expect(current_path).to eq new_user_session_path
  end
end