Rails.application.routes.draw do
  root "welcome#index"
  # get "/about", to: "welcome#about", as: "about"
  # Authorization route
  get "/auth/facebook/callback" => "sessions#create_facebook"
  get    "/login", to: "sessions#new"
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :users, only: [:new, :create]

  get '/:user/trips', to: "trips#index", as: "user_trips"
  post '/:user/trips', to: "trips#create"
  get '/trips/:trip_id', to: "trips#show", as: "trip_path"
  delete '/:user/trips/:trip_id', to: "trips#destroy"

  resources :trips, except: [:new, :create, :show, :destroy]

  post "/trips/:trip_id/activity/:activity_id/:activity_title/:activity_price/:activity_duration/tasks", to: "tasks#create_from_things_todo", as: "new_task_from_things_todo"
  post "/trips/:trip_id/tasks", to: "tasks#create"

  get "/trips/:trip_id/tasks/:task_id", to: "tasks#show"
  delete "/trips/:trip_id/tasks/:task_id", to: "tasks#destroy"
  get "/trips/:trip_id/tasks/:task_id/edit", to: "tasks#edit"
  put "/trips/:trip_id/tasks/:task_id", to: "tasks#update"

  put "/trips/:trip_id/budget/:amount_id/:amount_total", to: "budgets#update"
  post "/trips/:trip_id/budget", to: "budgets#create"
  delete "/trips/:trip_id/budget/:budget_id", to: "budgets#destroy_amount_per_day"
  delete "/trips/:trip_id/budget", to: "budgets#destroy_budget"

  post "/trips/:trip_id/wardrobe/:date", to: "wardrobes#create"
  delete "/trips/:trip_id/wardrobe/:wardrobe_id", to: "wardrobes#remove_wardrobe_item_from_trip"


  # post "/trips/:trip", to: "tasks#create"
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
