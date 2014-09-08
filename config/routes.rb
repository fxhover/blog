Rails.application.routes.draw do
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

  root "blogs#index"

  resources :blogs, only:[:index] do
    collection do
      post 'upload_img'
      get 'set'
      post 'set_userinfo'
      get 'set_blog'
      post 'update_blog'
      get 'about'
      get 'change_password'
      post 'update_password'
      post 'preview'
    end

  end

  resources :articles do
    member do
      post 'star'
    end

    resources :comments
  end

  get 'register' => 'users#register'
  get 'login' => 'users#login'
  get 'logout' => 'users#logout'
  resources :users do
    collection do
      get 'register'
      post 'register_confirm'
      get 'login'
      post 'login_confirm'
      get 'logout'
      get 'send_active_mail'
      get 'activation'
      get 'forget_password'
      post 'forget_password_confirm'
      get 'change_pw'
      post 'change_pw_confirm'
    end
  end

end
