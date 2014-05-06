MDS::Application.routes.draw do
  get "lists/index"
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_scope :users do
    get "/users/:user_id/lists" => "lists#index", :as => :user_lists
    post "/users/:user_id/lists" => "lists#create"
    get "/users/:user_id/lists/new" => "lists#new", :as => :new_user_list
    get "/users/:user_id/lists/:id/edit" => "lists#edit", :as => :edit_user_list
    get "/users/:user_id/lists/:id" => "lists#show", :as => :user_list
    patch "/users/:user_id/lists/:id" => "lists#update"
    put "/users/:user_id/lists/:id" => "lists#update"
    delete "/users/:user_id/lists/:id" => "lists#destroy"
    
    get "/users/:user_id/reviews" => "reviews#index", :as => :user_reviews
    post "/users/:user_id/reviews" => "reviews#create"
    get "/users/:user_id/reviews/new" => "reviews#new", :as => :new_user_review
    get "/users/:user_id/reviews/:id/edit" => "reviews#edit", :as => :edit_user_review
    get "/users/:user_id/reviews/:id" => "reviews#show", :as => :user_review
    patch "/users/:user_id/reviews/:id" => "reviews#update"
    put "/users/:user_id/reviews/:id" => "reviews#update"
    delete "/users/:user_id/reviews/:id" => "reviews#destroy"
  end

  resources :movies

  get 'search' => 'searches#search'

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
