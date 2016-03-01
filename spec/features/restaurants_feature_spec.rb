require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants added' do

    scenario 'should promt to add restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add restaurant'
    end

  end

end
