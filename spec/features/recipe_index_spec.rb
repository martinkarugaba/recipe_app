require 'rails_helper'

RSpec.describe 'food index' do
  before :each do
    login_user
    visit recipes_path
  end

  it 'see the recipes title' do
    expect(page).to have_content('Recipes')
  end

  it 'see the add new recipe button' do
    expect(page).to have_link('Add New Recipe')
  end
end
