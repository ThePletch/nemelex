class Card < ApplicationRecord
  belongs_to :deck

  delegate :readyable?, to: :deck

  scope :readied, -> { where(readied: true) }

  alias_attribute :readied?, :readied
end
