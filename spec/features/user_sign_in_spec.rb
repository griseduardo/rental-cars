require 'rails_helper'

feature 'User sign in' do

  # Objetivo: a partir da tela inicial, ir para a tela de login
  scenario 'from home page' do
    # Arrange
    # Act
    visit root_path
    # Assert
    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    # Arrange
    User.create!(name: 'João Almeida', email: 'joao@email.com', 
                                       password: '12345678')
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(page).to have_content 'João Almeida'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'and sign out' do
    User.create!(name: 'João Almeida', email: 'joao@email.com', 
                 password: '12345678')  
      
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'João Almeida'
    expect(page).not_to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Sair'
  end
end