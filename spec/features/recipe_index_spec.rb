require 'rails_helper'

RSpec.describe 'food index', type: :feature do
  before :each do
    login_user
    visit recipes_path
  end

  it 'displays the recipes title' do
    expect(page).to have_content('Recipes')
  end

  it 'displays the add new recipe button' do
    expect(page).to have_link('Add New Recipe')
  end

  it 'displays the table headers' do
    within 'thead' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      expect(page).to have_content('Action')
    end
  end

  context 'when no recipes are present' do
    before do
      Recipe.delete_all
      visit recipes_path
    end

    it 'displays a message for no recipes found' do
      within '[data-testid="no-recipes-message"]' do
        expect(page).to have_content('No recipes found.')
      end
    end
  end
end
