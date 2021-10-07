Rails.application.routes.draw do
  root "home#index"
  namespace :shopping_cart do
    resources :line_items, only: :create do
      resources :quantities, only: [] do
        post :increase, on: :collection
        post :decrease, on: :collection
      end
    end
  end
end
