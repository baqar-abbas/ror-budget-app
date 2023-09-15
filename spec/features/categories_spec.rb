require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
    include Devise::Test::IntegrationHelpers
  context 'when user is signed in' do
    let(:user) { User.create(name: 'User Name', email: 'user@example.com', password: 'password') }

    before do
      sign_in user
    end

    scenario 'displays a list of categories' do
      # Create some categories associated with the user
      categories = [
        Category.create(name: 'Category 1', icon: 'icon1', user: user),
        Category.create(name: 'Category 2', icon: 'icon2', user: user)
      ]

      visit user_categories_path(user)

      # Verify that the categories are displayed
      categories.each do |category|
        expect(page).to have_content(category.name)
      end
    end

    scenario 'allows the user to create a new category' do
        visit user_categories_path(user) # Use user_categories_path

      # Click a link/button to create a new category
      click_link 'NEW CATEGORY'

      # Fill in the form to create a new category
      fill_in 'Name', with: 'New Category Name'
      fill_in 'Icon', with: 'New Icon Name'
      click_button 'Create Category'

      # Verify that the new category is created and displayed
      expect(page).to have_content('New Category Name')
    end
  end

  context 'when user is not signed in' do
    scenario 'displays a message for non-signed-in users' do

        # visit user_categories_path #user_categories_path

        visit root_path

      # Verify that a message is displayed for non-signed-in users
      expect(page).to have_content('You are not signed in')
    end
  end
end
