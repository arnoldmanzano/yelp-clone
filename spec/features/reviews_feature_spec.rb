require 'rails_helper'

feature 'reviewing restaurants' do

  let!(:java_me){Restaurant.create(name: 'Java-Me')}

  scenario 'allows users to add review using form' do
    visit '/restaurants'
    click_link 'Java-Me'
    click_link 'Review Java-Me'
    fill_in 'Body', with: 'Better than Java-U'
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq "/restaurants/#{java_me.id}"
    expect(page).to have_content 'Better than Java-U'
  end

end
