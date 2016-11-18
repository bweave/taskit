Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register',
    password: 'secret'
  }

  resources :projects do
    resources :lists, shallow: true do
      put :sort, on: :collection
      resources :cards, shallow: true do
        put :sort, on: :collection
      end
    end
  end

  root to: 'home#index'

  # For details on the DSL available within this file,see http://guides.rubyonrails.org/routing.html
end
