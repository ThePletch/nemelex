class AddReadiedToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :readied, :boolean
  end
end
