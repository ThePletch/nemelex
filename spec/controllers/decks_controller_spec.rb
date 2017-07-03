require 'rails_helper'

describe DecksController do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET edit" do
    it "lets users edit an owned deck" do
      deck = FactoryGirl.create(:deck, user: @user)

      get :edit, params: { id: deck.id }
      expect(response).to have_http_status :ok
    end

    it "prevents users from editing an unowned deck" do
      other_user = FactoryGirl.create(:user)
      deck = FactoryGirl.create(:deck, user: other_user)

      get :edit, params: { id: deck.id }
      expect(response).to redirect_to(decks_path)
    end
  end

  describe "GET show" do
    it "shows a user's deck" do
      deck = FactoryGirl.create(:deck, user: @user)
      get :show, params: { id: deck.id }
      expect(response).to have_http_status :ok
    end

    it "shows another user's deck" do
      # not owned by @user
      deck = FactoryGirl.create(:deck)
      get :show, params: { id: deck.id }
      expect(response).to have_http_status :ok
    end
  end

  describe "POST create" do
    it "creates a deck" do
      deck = FactoryGirl.build(:deck, name: 'uNiQuE nAmE')

      post :create, params: { deck: deck.attributes }
      expect(Deck.where(name: 'uNiQuE nAmE')).to exist
    end
  end

  describe "PATCH update" do
    it "lets users update an owned deck" do
      deck = FactoryGirl.create(:deck, user: @user)

      patch :update, params: { id: deck.id, deck: deck.attributes.merge(name: 'New Name') }
      expect(response).to redirect_to(deck_path(deck))
      expect(deck.reload.name).to eq 'New Name'
    end

    it "does not let users update an unowned deck" do
      other_user = FactoryGirl.create(:user)
      deck = FactoryGirl.create(:deck, user: other_user)

      patch :update, params: { id: deck.id, deck: deck.attributes.merge(name: 'New Name') }
      expect(response).to redirect_to(decks_path)
      expect(deck.reload.name).not_to eq 'New Name'
    end
  end

  describe "DELETE destroy" do
    it "lets users destroy an owned deck" do
      deck = FactoryGirl.create(:deck, user: @user)

      delete :destroy, params: { id: deck.id }
      expect(response).to redirect_to(decks_path)
      expect(Deck.where(id: deck.id)).not_to exist
    end

    it "does not let users destroy an unowned deck" do
      other_user = FactoryGirl.create(:user)
      deck = FactoryGirl.create(:deck, user: other_user)

      delete :destroy, params: { id: deck.id }
      expect(response).to redirect_to(decks_path)
      expect(Deck.where(id: deck.id)).to exist
    end
  end
end
