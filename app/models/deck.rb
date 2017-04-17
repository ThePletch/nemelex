class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy

  accepts_nested_attributes_for :cards, allow_destroy: true

  validates_numericality_of :initial_hand_size, less_than_or_equal_to: Proc.new(&:number_readied), allow_blank: true,
    message: "Your initial hand can't be more cards than you have readied."

  def number_readied
    cards.readied.count
  end
end
