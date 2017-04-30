class Deck < ApplicationRecord
  def self.types
    Hash[[HoldEm, River, Maneuver].map do |descendant|
      [descendant.to_s, {
        description: descendant::DESCRIPTION,
        uses_deck: descendant.uses_deck?,
        readyable: descendant.readyable?
      }]
    end]
  end

  %w(readyable? uses_deck?).each do |instance_delegate|
    define_method(instance_delegate) do
      self.class.public_send(instance_delegate)
    end
  end

  belongs_to :user
  has_many :cards, dependent: :destroy

  accepts_nested_attributes_for :cards, allow_destroy: true, reject_if: lambda {|c| c['name'].blank? }

  # returns number of readied cards, should really be factored out
  def number_readied
    cards.count
  end

  # returns all cards marked as readied
  def readied_cards
    cards
  end

  # true if the deck type lets you ready cards
  def self.readyable?
    false
  end

  # true if the deck type allows you to draw from a deck
  def self.uses_deck?
    true
  end
end
