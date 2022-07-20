# frozen_string_literal: true

feature 'Creating a new Space' do
  xscenario 'A user can fill in the input boxes to create a new Space' do
    visit('/spaces/new')
    fill_in('name', with: 'Test Space')
    fill_in('description', with: 'Test Desc')
    fill_in('price_per_night', with: '120')

    click_button('Submit')

    expect(page).to have_content 'Name: Test Space | Description: Test Desc | £/Night: 120 | Posted by: '
  end
end
