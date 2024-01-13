require 'rails_helper'

RSpec.describe 'food index' do
  before :each do
    login_user
  end

  it 'see the welcome title ' do
    expect(page).to have_content('Welcome to our page')
  end
end
