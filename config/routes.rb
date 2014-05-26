MDS::Application.routes.draw do
  get "boxoffice/partial"
  get "lists/index"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations",
    :passwords => "passwords", :invitations => "invitations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_scope :user do
    get "/users/:username/lists" => "lists#index", :as => :user_lists
    post "/users/:username/lists" => "lists#create"
    get "/users/:username/lists/new" => "lists#new", :as => :new_user_list
    get "/users/:username/lists/:id/edit" => "lists#edit", :as => :edit_user_list
    get "/users/:username/lists/:id" => "lists#show", :as => :user_list
    patch "/users/:username/lists/:id" => "lists#update"
    put "/users/:username/lists/:id" => "lists#update"
    delete "/users/:username/lists/:id" => "lists#destroy"
    
    delete "/users/:username/lists/:id/:movie_id" => "lists#remove_movie", :as => :remove_user_list_movie
    get "/users/:username/lists/:id/add" => "lists#add_movies", :as => :user_list_list_movie_pairs
    post "/users/:username/lists/:id/add" => "lists#submit_movies"

    get "/users/:username/invitations" => "invitations#index", :as => :user_invitations

    get "/users/:username/reviews" => "reviews#index", :as => :user_reviews
    post "/users/:username/reviews" => "reviews#create"
    get "/users/:username/reviews/new/:id" => "reviews#new", :as => :new_user_review
    get "/users/:username/reviews/:id/edit" => "reviews#edit", :as => :edit_user_review
    get "/users/:username/reviews/:id" => "reviews#show", :as => :user_review
    patch "/users/:username/reviews/:id" => "reviews#update"
    put "/users/:username/reviews/:id" => "reviews#update"
    delete "/users/:username/reviews/:id" => "reviews#destroy"
  end

  resources :movies

  get 'search' => 'searches#search'
  get "in_place_search" => "searches#in_place_search", :as => :in_place_search
  
  # You can have the root of your site routed with "root"
  root 'welcome#home'

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
