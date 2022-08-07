Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"
    }
  # mount Base => "/"
  # root 'components#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "groups#index"

  resources :groups, :only => [:index, :create, :edit, :update] do
    member do
      put :join
      delete :quit
    end
  end
end
