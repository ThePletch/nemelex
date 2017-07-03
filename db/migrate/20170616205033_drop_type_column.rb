class DropTypeColumn < ActiveRecord::Migration[5.0]
  def change
    Deck.all.each do |d|
      attributes = {}

      case d.type
      when 'HoldEm'
        attributes = {readyable: false, uses_deck: false}
      when 'River'
        attributes = {readyable: false, uses_deck: true}
      when 'Maneuver'
        attributes = {readyable: true, uses_deck: true}
      end

      d.update_attributes(attributes)
    end
    remove_column :decks, :type
  end
end
