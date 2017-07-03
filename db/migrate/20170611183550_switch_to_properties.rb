class SwitchToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :decks, :readyable, :boolean, default: false
    add_column :decks, :uses_deck, :boolean, default: true
  end
end
