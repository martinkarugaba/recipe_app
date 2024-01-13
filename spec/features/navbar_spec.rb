require 'rails_helper'

RSpec.feature 'Navbar', type: :feature do
  context 'when user is signed out' do
    scenario 'displays the correct navbar links' do
      visit root_path

      expect(page).to have_link('Recipe App', href: '#')
      expect(page).to have_link('Add Food', href: '/foods')
      expect(page).to have_link('Recipes List', href: '/recipes')
      expect(page).to have_link('Public Recipes', href: '/recipes/public_recipes')
      expect(page).to have_link('Shopping List', href: '/shopping_list')

      expect(page).to have_button('Sign in')
      expect(page).to have_link('Sign up')
      expect(page).not_to have_button('Sign out')
    end
  end
end
