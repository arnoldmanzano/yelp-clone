require 'rails_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many(:reviews).dependent(:destroy) }

  it 'is not valid with name shorter than 3 chars' do
    restaurant = Restaurant.new(name: 'ju')
    expect(restaurant).not_to be_valid
    expect(restaurant).to have(1).error_on(:name)
  end
end
