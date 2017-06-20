require 'spec_helper'

describe "deck form", js: true do
  before :each do
    @user = FactoryGirl.create(:user)
    login_as @user
  end

  context "for a new deck" do
    before :each do
      visit new_deck_path
    end

    it "should have 'uses deck' checked by default" do
      expect(page.find("#uses_deck")).to be_checked
    end
  end

  context "for a deck with a card" do
    before :each do
      @deck = FactoryGirl.create(:deck, user: @user)
      @card = FactoryGirl.create(:card, deck: @deck)
    end

    it "should display a 'readied' checkbox when 'only draw readied' is checked" do
      visit edit_deck_path(@deck)
      page.find("#readyable").set(true)

      expect(page).to have_selector(".readyable-toggle .card-readyable-checkbox")
    end

    it "should not display a 'readied' checkbox when 'only draw readied' is unchecked" do
      visit edit_deck_path(@deck)
      page.find("#readyable").set(false)

      expect(page).to have_selector(".readyable-toggle .card-readyable-checkbox", visible: false)
    end

    it "should disable the 'always draw' checkbox for a card when 'readied' is unchecked", pending: "to be implemented" do
      visit edit_deck_path(@deck)
      page.find("#readyable").set(true)

      page.find(".card-readyable-checkbox").set(false)
      expect(page.find(".card-always-draw-checkbox")).to be_disabled
    end

    it "should enable the 'always draw' checkbox for a card when 'readied' is checked" do
      visit edit_deck_path(@deck)
      page.find("#readyable").set(true)

      page.find(".card-readyable-checkbox").set(true)
      expect(page.find(".card-always-draw-checkbox")).not_to be_disabled
    end

    it "should add another card when 'Add a Card' is clicked", pending: "fuckery" do
      visit edit_deck_path(@deck)
      expect(page).to have_selector(".card-block", count: 1)
      page.find("#add-card").click
      # hacky waiting finder since have_selector(count:) doesn't block
      expect(page).to have_selector("#card-")
      expect(page).to have_selector(".card-block", count: 2)
    end
  end

  it "should not delete the card from the form if it is an existing card"

  it "should delete the card from the form if it is a new, unsaved card"

  it "should persist changes when 'update deck' is clicked, including to cards"

  it "should disable the 'initial hand size' field and display a tooltip when 'use deck' is unchecked"

  it "should display an 'always draw' checkbox when 'use deck' is checked"

  it "should not display an 'always draw' checkbox when 'use deck' is unchecked"

  it "should return a validation error if more cards are marked 'always draw' than the initial hand size"
end
