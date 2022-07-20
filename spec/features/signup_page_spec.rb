# frozen_string_literal: true

require 'spec_helper'
feature 'Sign ups' do
  scenario 'user can sign up and be signed in' do
    visit('/')
    fill_in('username', with: 'Test User')
    fill_in('firstname', with: 'Test')
    fill_in('lastname', with: 'User')
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'test123')
    fill_in('password_confirmation', with: 'test123')
    click_button('Submit')
    expect(page).to have_content('Thank you for registering with us, Test User.')
  end
end
