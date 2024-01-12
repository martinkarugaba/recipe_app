require 'rails_helper'

RSpec.describe 'food index' do
  before :each do
    login_user
    visit foods_path
  end

  it 'see add new food button ' do
    expect(page).to have_link('Add new food')
  end

  it 'see the column food' do
    expect(page).to have_content('Food')
  end

  it 'see the column Measurement Unit' do
    expect(page).to have_content('Measurement Unit')
  end

  it 'see the column Price' do
    expect(page).to have_content('Price')
  end

  it 'see the column Quantity' do
    expect(page).to have_content('Quantity')
  end

  it 'see the column Action' do
    expect(page).to have_content('Action')
  end

  it 'see the delete button' do
    expect(page).to have_link('Delete')
  end

  context 'when no foods are available' do
    before do
      Food.delete_all
      visit foods_path
    end

    it 'displays a message for no foods available' do
      within '[data-testid="no-foods-message"]' do
        expect(page).to have_content('No foods available.')
      end
    end
  end
end
