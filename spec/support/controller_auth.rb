require 'rails_helper'

shared_examples 'an authenticated page' do |target|
  it "redirects an unauthenticated user to the login page" do
    get target
    byebug
    expect(response).to redirect_to(new_user_session_path)
  end
end

shared_examples 'an unauthenticated page' do |page|
end
