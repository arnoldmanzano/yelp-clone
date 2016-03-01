require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants added' do

    scenario 'should promt to add restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add restaurant'
    end

  end

  context 'restaurant have been added' do
    before do
      Restaurant.create(name: 'Java-U')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Java-U'
      expect(page).not_to have_content 'No restaurants'
    end

  end

  context 'create restaurant' do

    scenario 'fill out a form, then display the restaurant' do
      visit '/restaurants'
      click_link 'Add restaurant'
      fill_in 'Name', with: 'Java-U'
      click_button 'Create restaurant'
      expect(page).to have_content 'Java-U'
      expect(current_path).to eq '/restaurants'
    end

  end

end
