FactoryGirl.define do
  factory :card do
    deck
    sequence(:name) {|n| "Card Name #{n}" }
    description "A deskript"
  end
end
