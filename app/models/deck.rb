class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy

  accepts_nested_attributes_for :cards, allow_destroy: true

  def number_readied
    cards.readied.count
  end
end
