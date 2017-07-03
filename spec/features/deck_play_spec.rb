require 'rails_helper'

describe "deck play", js: true do
  before :each do
    @deck = FactoryGirl.create(:deck)
  end

  context "with a card" do
    before :each do
      @card = FactoryGirl.create(:card, deck: @deck)
    end

    it "should let you discard/undiscard a card" do
      visit play_deck_path(@deck)

      expect(page).to have_selector(".discard")
      click_on "Discard"
      expect(page).not_to have_selector(".discard")
      expect(page).to have_selector(".restore")
      click_on "Restore"
      expect(page).not_to have_selector(".restore")
      expect(page).to have_selector(".discard")
    end

    it "should not change discarded/undiscarded status when a card is drawn" do
      @second_card = FactoryGirl.create(:card, deck: @deck)
      visit play_deck_path(@deck)

      first_card = page.find(".card")
      first_card.find(".discard").click

      click_on "Draw"
      expect(first_card).not_to have_selector(".discard")
      expect(first_card).to have_selector(".restore")
    end

    it "should undiscard all cards when the 'deal' button is pressed" do
      visit play_deck_path(@deck)

      card = page.find("#card-#{@card.id}")
      card.find(".discard").click

      click_on "Deal"
      expect(card).to have_selector(".discard")
      expect(card).not_to have_selector(".restore")
    end
  end

  context "with a deck with 'use deck' enabled" do
    before :each do
      @deck.update_attributes(uses_deck: true)
    end

    # this spec will pass 10% of the time even if the functionality is broken
    # no real way to avoid this, just ways to reduce those odds
    it "should always add cards marked 'always draw' to the hand" do
      cards = FactoryGirl.create_list(:card, 10, deck: @deck)
      cards[0].update_attributes(always_draw: true)

      visit play_deck_path(@deck)

      expect(page).to have_selector("#card-#{cards[0].id}")
    end

    # spec will fail 0.007% of the time, if this proves unacceptable
    # then increasing the deck/hand size decreases the flake rate factorially
    it "should draw a new hand when 'deal' is pressed" do
      @deck.update_attributes(initial_hand_size: 8)
      cards = FactoryGirl.create_list(:card, 20, deck: @deck)

      visit play_deck_path(@deck)

      initially_visible_ids = page.all(".card").map{|c| c['data-id'] }

      click_on "Deal"
      expect(page.all(".card").map{|c| c['data-id']}).not_to match_array(initially_visible_ids)
    end

    it "should immediately draw a hand on page load" do
      card = FactoryGirl.create(:card, deck: @deck)

      visit play_deck_path(@deck)
      expect(page).to have_selector("#card-#{card.id}")
    end

    it "should disable the 'draw' button when all cards are drawn, re-enabling it on a new deal" do
      @deck.update_attributes(initial_hand_size: 0)
      cards = FactoryGirl.create_list(:card, 2, deck: @deck)

      visit play_deck_path(@deck)
      click_on "Draw"
      expect(page.find("#draw")).not_to be_disabled
      click_on "Draw"
      expect(page.find("#draw")).to be_disabled
      click_on "Deal"
      expect(page.find("#draw")).not_to be_disabled
    end
  end

  context "with a deck with 'use deck' disabled" do
    before :each do
      @deck.update_attributes(uses_deck: false)
    end

    it "should immediately draw all cards on page load" do
      cards = FactoryGirl.create_list(:card, 3, deck: @deck)

      visit play_deck_path(@deck)
      expect(page.all(".card").length).to eq 3
    end

    it "should not display a 'draw' button at all" do
      visit play_deck_path(@deck)
      expect(page).not_to have_selector("#draw")
    end

    it "should still display all cards when 'deal' is pressed" do
      cards = FactoryGirl.create_list(:card, 3, deck: @deck)

      visit play_deck_path(@deck)
      click_on "Deal"
      expect(page.all(".card").length).to eq 3
    end
  end

  context "with a deck with 'readyable' enabled" do
    before :each do
      @deck.update_attributes(readyable: true)
    end

    it "should only add readied cards to the deck" do
      # skipping any randomness from drawing by not using a deck
      @deck.update_attributes(uses_deck: false)
      unreadied_card = FactoryGirl.create(:card, deck: @deck, readied: false)
      readied_card = FactoryGirl.create(:card, deck: @deck, readied: true)

      visit play_deck_path(@deck)
      expect(page).to have_selector("#card-#{readied_card.id}")
      expect(page).to have_no_selector("#card-#{unreadied_card.id}")
    end
  end

  context "with a deck with 'readyable' disabled" do
    before :each do
      @deck.update_attributes(readyable: false)
    end

    it "should add cards to the deck regardless of them being readied" do
      # skipping any randomness from drawing by not using a deck
      @deck.update_attributes(uses_deck: false)
      unreadied_card = FactoryGirl.create(:card, deck: @deck, readied: false)
      readied_card = FactoryGirl.create(:card, deck: @deck, readied: true)

      visit play_deck_path(@deck)
      expect(page.all(".card").length).to eq 2
    end
  end
end
