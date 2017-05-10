require 'rails_helper'

describe HoldEm do
  it_behaves_like "a type of deck"
  it_behaves_like "an unreadyable deck"
  it_behaves_like "a deckless deck"
end
