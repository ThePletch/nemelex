class Card < ApplicationRecord
  belongs_to :deck

  scope :readied, -> { where(readied: true) }

  alias_attribute :readied?, :readied
end
