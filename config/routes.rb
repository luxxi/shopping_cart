Rails.application.routes.draw do
  root "home#index"
  namespace :shopping_cart do
    resources :line_items, only: :create
  end
end
