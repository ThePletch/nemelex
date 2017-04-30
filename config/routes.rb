Rails.application.routes.draw do
  resources :decks, shallow: true do
    member do
      get "play"
    end
  end
  devise_for :users

  root to: "decks#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
