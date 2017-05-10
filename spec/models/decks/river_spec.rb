require 'rails_helper'

describe River do
  it_behaves_like "a type of deck"
  it_behaves_like "an unreadyable deck"
  it_behaves_like "a random-draw deck"
end
