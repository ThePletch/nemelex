class Maneuver < Deck
  DESCRIPTION = "Designed to manage Tome of Battle maneuvers. Only cards marked as 'readied' are added to your deck."

  def self.model_name
    Deck.model_name
  end

  def number_readied
    cards.readied.count
  end

  def readied_cards
    cards.readied
  end

  def self.readyable?
    true
  end
end
