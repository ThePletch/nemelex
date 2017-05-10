# TODO verify how sti works with factorygirl
FactoryGirl.define do
  factory :deck, class: 'River' do
    sequence(:name) {|n| "Deck Name #{n}" }
    type 'River'
    user

    factory :hold_em_deck, class: 'HoldEm' do
      type 'HoldEm'
    end

    factory :river_deck

    factory :maneuver_deck, class: 'Maneuver' do
      type 'Maneuver'
    end
  end
end
