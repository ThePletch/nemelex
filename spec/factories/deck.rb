# TODO verify how sti works with factorygirl
FactoryGirl.define do
  factory :deck do
    sequence(:name) {|n| "Deck Name #{n}" }
    initial_hand_size 1
    uses_deck true
    user

    factory :hold_em_deck do
      uses_deck false
    end

    factory :river_deck

    factory :readyable_deck do
      readyable true
    end
  end
end
