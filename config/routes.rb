Rails.application.routes.draw do
  root 'courses#index'
  resources :courses, except: :show do
    resources :materials, except: :show
    patch :duplicate    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
