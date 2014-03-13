TreeHouse::Application.routes.draw do
  resources :works

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'site#home'
  
  # => Site Routes
    match '/signin',   to: 'sessions#new',     via: 'get'
    match '/logout',  to: 'sessions#destroy',  via: 'delete'
    match '/signup',  to: 'users#new',        via: 'get'
    match '/guide',   to: 'site#guide',       via: 'get'
    match '/about',   to: 'site#about',       via: 'get'
    match '/faq',     to: 'site#faq',         via: 'get'
    match '/search',  to: 'works#search',      via:  'get'
    match '/search/:id',  to: 'works#search',      via:  'get'
    match '/stories', to: 'users#stories',    via: 'get'
    match '/stats', to: 'site#stats',        via: 'get'
    
    match '/download/:id', to: 'works#topdf',   via: 'get', defaults: { format: 'pdf'}
    match '/get_user_image/:id', to: 'users#get_user_image', via: 'get'
  # => Post routes
    match '/drafts',  to: 'works#create_draft',via: 'post'
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
