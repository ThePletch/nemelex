class River < Deck
  DESCRIPTION = "Draw cards at random from a shuffled deck."

  def self.model_name
    Deck.model_name
  end
end
