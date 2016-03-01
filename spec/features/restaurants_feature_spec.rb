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

end
