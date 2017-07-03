class Deck < ApplicationRecord
  # TODO: Code cleanup location
  belongs_to :user
  has_many :cards, dependent: :destroy

  accepts_nested_attributes_for :cards, allow_destroy: true, reject_if: lambda {|c| c['name'].blank? }

  # returns number of readied cards, should really be factored out
  def number_readied
    readied_cards.count
  end

  # returns all cards marked as readied
  def readied_cards
    if readyable?
      cards.readied
    else
      cards
    end
  end

  # true if the deck lets you ready cards
  def readyable?
    readyable
  end

  # true if the deck allows you to draw from a deck
  def uses_deck?
    uses_deck
  end
end
