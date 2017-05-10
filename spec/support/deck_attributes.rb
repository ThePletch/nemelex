require 'rails_helper'

# TODO: Move to /spec/support
shared_examples "a type of deck" do
  it "still uses Deck as a model name" do
    expect(described_class.model_name).to eq "Deck"
  end

  it "destroys owned cards when destroyed" do
    deck = FactoryGirl.create("#{described_class.to_s.underscore}_deck")
    cards = FactoryGirl.create_list(:card, 2, deck: deck)
    card_ids = cards.map(&:id)

    deck.destroy!
    expect(Card.where(id: card_ids)).to be_empty
  end
end

shared_examples 'a readyable deck' do
  before :each do
    @deck = FactoryGirl.create("#{described_class.to_s.underscore}_deck")
    @cards = FactoryGirl.create_list(:card, 2, deck: @deck)
  end

  it "only returns readied cards from readied_cards" do
    @cards.last.update_attributes(readied: false)
    @cards.map(&:reload)
    expect(@deck.readied_cards).to eq [@cards.first]
  end

  it "only includes readied cards in its readied cards count" do
    expect(@deck.number_readied).to eq @cards.length
    @cards.last.update_attributes(readied: false)
    expect(@deck.number_readied).to eq @cards.length - 1
  end
end

shared_examples "an unreadyable deck" do
  before :each do
    @deck = FactoryGirl.create("#{described_class.to_s.underscore}_deck")
    @cards = FactoryGirl.create_list(:card, 2, deck: @deck)
  end

  it "treats all cards as readied" do
    expect(@deck.readied_cards).to match_array @cards
    @cards.last.update_attributes(readied: false)
    expect(@deck.readied_cards).to match_array @cards
  end

  it "returns the number of cards as its readied count" do
    expect(@deck.number_readied).to eq @cards.length
    @cards.last.update_attributes(readied: false)
    expect(@deck.number_readied).to eq @cards.length
  end
end

shared_examples 'a deckless deck' do
  it "does not use a deck" do
    expect(described_class.uses_deck?).to eq false
  end

  it "has an initial hand size of all cards" do
    deck = FactoryGirl.create("#{described_class.to_s.underscore}_deck")
    cards = FactoryGirl.create_list(:card, 2, deck: deck)
    expect(deck.initial_hand_size).to eq 2
    FactoryGirl.create(:card, deck: deck)
    expect(deck.initial_hand_size).to eq 3
  end
end

shared_examples 'a random-draw deck' do
  it "uses a deck" do
    expect(described_class.uses_deck?).to eq true
  end

  it "returns its initial hand size attribute when set" do
    deck = FactoryGirl.create("#{described_class.to_s.underscore}_deck", initial_hand_size: 1)
    cards = FactoryGirl.create_list(:card, 2, deck: deck)
    expect(deck.initial_hand_size).to eq 1
    FactoryGirl.create(:card, deck: deck)
    expect(deck.initial_hand_size).to eq 1
  end
end
