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

    scenario 'user should not be able to add restaurant' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).not_to have_button 'Create Restaurant'
      expect(page).to have_content 'Log in'
    end
  end

  context 'user signed in' do
    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'my@email.com')
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

  context 'user creates and another user signs in' do
    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'my@email.com')
      fill_in('Password', with: 'mypassword')
      fill_in('Password confirmation', with: 'mypassword')
      click_button('Sign up')
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Sign out'
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'you@email.com')
      fill_in('Password', with: 'yourpassword')
      fill_in('Password confirmation', with: 'yourpassword')
      click_button('Sign up')
    end

    scenario 'user can only edit/delete restaurants they created' do
      click_link 'Delete KFC'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'Restaurant deleted successfully'
    end

    # Users can only leave one review per restaurant
    # Users can delete only their own reviews

  end
end
