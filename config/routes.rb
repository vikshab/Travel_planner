Rails.application.routes.draw do
  root "welcome#index"
  # get "/about", to: "welcome#about", as: "about"
  # Authorization route
  get "auth/facebook/callback" => "sessions#create_facebook"
  get    "/login", to: "sessions#new"
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users, only: [:new, :create]

  get '/:user/trips', to: "trips#index", as: "user_trips"
  get '/:user/trips/new', to: "trips#new", as: "new_trip"
  post '/:user/trips', to: "trips#create"
  get '/trips/:id', to: "trips#show", as: "trip_path"
  delete '/:user/trips/:id', to: "trips#destroy"
  # get '/:user/trips', to: "users#show", as: "dashboard"

  # get '/:user/dashboard/things_todo', to: "users#things_todo"

  post "/trips/search", to: "trips#search", as: "search"
  get "/trips/:destination/:start_date/:end_date", to: "expedia#results", as: "expedia_results"

  resources :trips, except: [:new, :create, :show, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
