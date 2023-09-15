# spec/controllers/categories_controller_spec.rb

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe 'GET #index' do
    it 'returns a success response for signed-in users' do
      user = User.create(
        name: 'User Name',
        email: 'user@example.com',
        password: 'password'
      )
      sign_in user
      get :index
      expect(response).to be_successful
    end

    it 'returns a success response for non-signed-in users' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      user = User.create(
        name: 'User Name',
        email: 'user@example.com',
        password: 'password'
      )
      sign_in user
      get :new, params: { user_id: user.id } # Provide the user_id parameter
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    

    it 'creates a new category for a user' do
      user = User.create(
        name: 'User Name',
        email: 'user@example.com',
        password: 'password'
      )
      sign_in user
    
      # Define the category attributes you want to create
      category_params = {
        name: 'New Category',
        icon: 'fa-utensils',
        user_id: user.id
      }
    
      # Make a POST request to create a new category for the user
      post :create, params: { user_id: user.id, category: category_params }
    
      # Expect that the category was created successfully
      expected_url = user_category_path(user, assigns(:category)) + ".82"
      expect(response.location).not_to include(".82")

      expect(assigns(:category)).to be_a(Category)

      expect(assigns(:category)).to be_persisted
    end
  end
end
