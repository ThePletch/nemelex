class AddInitialHandSizeToDecks < ActiveRecord::Migration[5.0]
  def change
    add_column :decks, :initial_hand_size, :integer
  end
end
