Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :zipcode_ranges
  end
end
