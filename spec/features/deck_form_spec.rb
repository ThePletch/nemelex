require 'rails_helper'

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
  context "for an existing deck" do
    before :each do
      @deck = FactoryGirl.create(:deck, user: @user)
    end

    context "with a card" do
      before :each do
        @card = FactoryGirl.create(:card, deck: @deck)
      end

      it "should display a 'readied' checkbox when 'only draw readied' is checked" do
        visit edit_deck_path(@deck)
        page.find("#readyable").set(true)

        expect(page).to have_selector(".readied-toggle .card-readied-checkbox")
      end

      it "should not display a 'readied' checkbox when 'only draw readied' is unchecked" do
        visit edit_deck_path(@deck)
        page.find("#readyable").set(false)

        expect(page).to have_selector(".readied-toggle .card-readied-checkbox", visible: false)
      end

      it "should disable the 'always draw' checkbox for a card when 'readied' is unchecked" do
        visit edit_deck_path(@deck)
        page.find("#readyable").set(true)

        page.find(".card-readied-checkbox").set(false)
        expect(page.find(".card-always-draw-checkbox")).to be_disabled
      end

      it "should enable the 'always draw' checkbox for a card when 'readied' is checked" do
        visit edit_deck_path(@deck)
        page.find("#readyable").set(true)

        page.find(".card-readied-checkbox").set(true)
        expect(page.find(".card-always-draw-checkbox")).not_to be_disabled
      end

      it "should add another card when 'Add a Card' is clicked" do
        visit edit_deck_path(@deck)
        expect(page).to have_selector(".card", count: 1)

        page.find("#add-card").click

        expect(page).to have_selector("#card-tmp")
        expect(page).to have_selector(".card", count: 2)
      end

      it "should not delete the card from the form when 'delete' is clicked if it is an existing card" do
        visit edit_deck_path(@deck)
        expect(page).to have_selector(".card", count: 1)

        page.find(".card .card-delete-checkbox").click

        expect(page.find(".card-delete-checkbox")).not_to be_disabled
        expect(page).to have_selector(".card", count: 1)
      end

      it "should persist changes when 'update deck' is clicked, including to cards" do
        visit edit_deck_path(@deck)

        fill_in :deck_name, with: "NEW NAME"
        page.find(".card-name").set("NEW CARD NAME")
        click_on "Update Deck"

        expect(@deck.reload.name).to eq "NEW NAME"
        expect(@card.reload.name).to eq "NEW CARD NAME"
      end

      it "should display an 'always draw' checkbox when 'use deck' is checked" do
        visit edit_deck_path(@deck)

        page.find("#uses_deck").set(true)

        expect(page).to have_selector(".card .card-always-draw-checkbox", visible: true)
      end

      it "should not display an 'always draw' checkbox when 'use deck' is unchecked" do
        visit edit_deck_path(@deck)

        page.find("#uses_deck").set(false)

        expect(page).not_to have_selector(".card .card-always-draw-checkbox", visible: true)
      end
    end

    it "should delete the card from the form if it is a new, unsaved card" do
      visit edit_deck_path(@deck)

      expect(page).not_to have_selector(".card")

      page.find("#add-card").click

      expect(page).to have_selector(".card")
      page.find(".card .card-delete-checkbox").click
      expect(page).not_to have_selector(".card")
    end

    it "should disable the 'initial hand size' field and display a tooltip when 'use deck' is unchecked" do
      visit edit_deck_path(@deck)

      expect(page.find("#deck_initial_hand_size")).not_to be_disabled

      page.find("#uses_deck").set(false)

      expect(page.find("#deck_initial_hand_size")).to be_disabled
      expect(page).to have_content("puts all cards in your hand automatically")
    end
  end
end
