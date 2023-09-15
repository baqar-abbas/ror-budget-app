require 'rails_helper'

RSpec.describe UsersController, type: :controller do
# This is a helper method to create a new user
def create_user(name: 'John Doe', email: 'johndoe@example.com', password: 'password')
    User.create(name: name, email: email, password: password)
  end

  describe 'GET #index' do
    it 'should return a success response' do
      get :index
      expect(response).to be_successful
    end

end

describe 'GET #show' do
  it 'should return a success response' do
    user = create_user
    get :show, params: { id: user.id }
    expect(response).to be_successful
  end

  it 'should return the requested user' do
    user = create_user
    get :show, params: { id: user.id }
    expect(assigns(:user)).to eq(user)
  end
end

describe 'POST #create' do
  it 'should create a new user' do
    expect do
      post :create, params: { user: { name: 'John Doe', email: 'johndoe@example.com', password: 'password' } }
    end.to change(User, :count).by(1)
  end

  it 'should redirect to the new user' do
    post :create, params: { user: { name: 'John Doe', email: 'johndoe@example.com', password: 'password' } }
    expect(response).to redirect_to(user_path(User.last))
  end
end
end