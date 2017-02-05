Rails.application.routes.draw do
  root 'courses#index'
  resources :courses, except: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
