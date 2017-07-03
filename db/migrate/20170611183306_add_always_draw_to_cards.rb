class AddAlwaysDrawToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :always_draw, :boolean, default: false
  end
end
