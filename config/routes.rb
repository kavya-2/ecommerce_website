Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :categories
  end
end
