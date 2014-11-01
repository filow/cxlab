Rails.application.routes.draw do


  namespace :manage do
    resources :sections
  end

  namespace :index do
  get 'index/index'
  end

  root 'index/index#index'
  
  namespace :manage do
    resources :admins 
    resources :roles
    resources :nodes,only: [:index]
    resources :configs
    resources :contests do 
      delete 'recover' => 'contests#recover'
    end
    resources :competes do
      resources :sections 
    end
    resources :news do
      patch 'draft' => 'news#draft'
      patch 'publish' => 'news#publish'
      patch 'recycle' => 'news#recycle'
    end
    get '/news_index_deleted'=>'news#index_deleted'
    get '/news_index_draft'=>'news#index_draft'
    resources :professions,except: [:new,:show]
    resources :students
    get '/'=> 'index#index'
    get  '/login'=>'session#index',as:'login'
    post '/login'=>'session#create'
    delete '/logout'=>'session#logout',as:'logout'

    get 'index/index'
    get 'index/dashboard'

    # 个人信息设置
    get 'self/index'
    post 'self/update'
  end

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
