class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
