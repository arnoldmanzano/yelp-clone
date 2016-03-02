require 'rails_helper'

feature 'User can sign in and out' do
  context 'user not signed in and on the homepage' do
    scenario 'user should see "sign in" link and "sign up" link' do
      visit '/'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'user should not see "sign out" link' do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end

  context 'user signed in' do
    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'my@email.comm')
      fill_in('Password', with: 'mypassword')
      fill_in('Password confirmation', with: 'mypassword')
      click_button('Sign up')
    end

    scenario 'user should see a "sign out" link' do
      visit '/'
      expect(page).to have_link('Sign out')
    end

    scenario 'user should not see "sign in" link and "sign up" link' do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
