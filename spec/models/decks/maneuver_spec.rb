require 'rails_helper'

describe Maneuver do
  it_behaves_like "a type of deck"
  it_behaves_like "a readyable deck"
  it_behaves_like "a random-draw deck"
end
