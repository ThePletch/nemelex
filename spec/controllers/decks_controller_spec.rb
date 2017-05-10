require 'rails_helper'

describe DecksController do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET edit" do
    it "lets users edit an owned deck" do
      deck = FactoryGirl.create(:deck, user: @user)

      get :edit, id: deck.id
      expect(response).to have_http_status :ok
    end

    it "prevents users from editing an unowned deck" do
      other_user = FactoryGirl.create(:user)
      deck = FactoryGirl.create(:deck, user: other_user)

      get :edit, id: deck.id
      expect(response).to redirect_to(decks_path)
    end
  end

  describe "POST create" do
  end

  describe "PATCH update" do
    it "lets users update an owned deck"

    it "does not let users update an unowned deck"

    it "only lets users update owned cards"
  end

  describe "DELETE destroy" do
    it "only lets users destroy an owned deck"
  end
end
