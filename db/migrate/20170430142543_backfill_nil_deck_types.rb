class BackfillNilDeckTypes < ActiveRecord::Migration[5.0]
  def change
    Deck.where(type: nil).update_all(type: 'River')
  end
end
