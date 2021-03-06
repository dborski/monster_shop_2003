Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  resources :merchants

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id", to: "cart#decrement"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show"
  patch "/orders/:id", to: "orders#update"


  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/users/:user_id/edit", to: "users#edit"
  get "/users/:user_id/edit_password", to: "users#edit_password"
  patch "/users/:user_id", to: "users#update"


  get "/profile", to: "profiles#show"

  resources :sessions, only: [:create]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'



  get '/profile/orders', to: 'user_orders#index'
  get '/profile/orders/:id', to: 'user_orders#show'
  patch "/profile/orders/:id", to: "user_orders#update"

  namespace :admin do
    #/admin/dashboard
    get '/dashboard', to: "dashboard#index"
    patch '/merchants/:id/active', to: 'merchants#enable_disable'
    get '/users/:user_id/orders/:id', to: 'orders#show'
    patch '/users/:user_id/orders/:id', to: 'orders#update'
    resources :merchants, only: [:show, :index, :update]
    resources :users, only: [:show, :index]
    # get '/users/:user_id/orders', to: 'admin_users#order_index'
  end

  namespace :merchant do
    get '/dashboard', to: "dashboard#show"
    patch '/items/:id/active', to: 'items#enable_disable'
    get '/orders/:id', to: 'orders#show'

    resources :items, only: [:index, :update, :destroy, :new, :create, :edit]
    patch '/item_orders/:id', to: 'item_orders#update'
  end

end
