class AddTypeToDeck < ActiveRecord::Migration[5.0]
  def change
    add_column :decks, :type, :string
  end
end
