require 'rails_helper'

describe 'Car Category authorization' do
  it 'must be logged in to create' do
    post car_categories_path, params: {}

    expect(response).to redirect_to(new_user_session_path)
  end

  xit 'must be admin' do
    admin = create(:user, admin: false)

    login_as admin, scope: :user
    post car_categories_path, params: {}

    expect(response).to redirect_to(root_path)
    expect(response.body).to include('Você não tem permissão para realizar ação')
  end
end