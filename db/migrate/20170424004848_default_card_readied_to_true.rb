class DefaultCardReadiedToTrue < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :readied, :boolean, default: true

    Card.where(readied: nil).update_all(readied: true)
  end
end
