Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"
    }
  # mount Base => "/"
  get 'components', to: 'components#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "groups#index"

  resources :groups, :only => [:index, :create, :edit, :update, :show] do
    member do
      put :join
      post :invite
      delete :quit
      delete :remove_member
      put :process_group_request
    end
    collection do
      put :reject
      put :accept
    end
  end

  resources :posts, :only => [:show, :create, :edit, :update, :destroy]
  resources :comments, :only => [:create, :edit, :destroy, :update]
end
