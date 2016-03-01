require 'rails_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it 'invalid if rating is higher than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
