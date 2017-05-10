require 'rails_helper'

describe User do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  it "can have multiple decks" do
    2.times{ FactoryGirl.create(:deck, user: @user) }
    expect(@user.decks.length).to eq 2
  end

  it "destroys owned decks when destroyed" do
    decks = FactoryGirl.create_list(:deck, 2, user: @user)
    @user.destroy!
    expect(Deck.all).to be_empty
  end
end
