require 'rails_helper'

feature 'reviewing' do
  before do
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'my@email.com')
    fill_in('Password', with: 'mypassword')
    fill_in('Password confirmation', with: 'mypassword')
    click_button('Sign up')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

end
