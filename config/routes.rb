Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :recipes
    resources :users, only: [:index, :show] do
      member do
        get :following, :followers, :recipes
      end
    end
    resources :relationships, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
