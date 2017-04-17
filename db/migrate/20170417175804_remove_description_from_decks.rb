class RemoveDescriptionFromDecks < ActiveRecord::Migration[5.0]
  def change
    remove_column :decks, :description
  end
end
