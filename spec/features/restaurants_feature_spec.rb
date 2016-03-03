require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do

    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do

    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    before do
      user_signs_up
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KF'
        click_button 'Create Restaurant'
        expect(page).not_to have_content 'KF'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc) {Restaurant.create(name: "KFC")}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before do
      user_signs_up
      add_restaurant
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end    
  end

  context 'deleting restaurants' do

    before do
      user_signs_up
      add_restaurant
    end

    scenario 'let a user delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content('KFC')
      expect(page).to have_content('Restaurant deleted successfully')
    end
  end
end

feature 'reviewing' do
  before do
    user_signs_up
    Restaurant.create(name: 'KFC')
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    add_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so, so')
  end

  scenario 'allows users to delete a review' do
    visit '/restaurants'
    add_review
    click_link 'KFC'
    click_link 'Delete Review'
    expect(current_path).to eq '/restaurants'
    expect(page).not_to have_content('so, so')
    expect(page).to have_content('Review deleted successfully')
  end
end
