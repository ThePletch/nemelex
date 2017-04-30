class HoldEm < Deck
  DESCRIPTION = "There is no deck. All cards are in your hand immediately."

  def self.model_name
    Deck.model_name
  end

  def initial_hand_size
    cards.count
  end

  def self.uses_deck?
    false
  end
end
