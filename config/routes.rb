Rails.application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
  scope module: 'index' do
    get 'index/index'
    get 'login/' => 'session#index'
    post 'login/' => 'session#create'
    delete 'logout' => 'session#logout'
    get 'login/forgot' => 'session#forgot'
    get 'login/regist' => 'session#regist'
    post 'login/regist' => 'session#regist_handler'

    get 'user/index'
    get 'user/email_checked' => 'user#email_checked'
    get 'user/email_checked_handler' => 'user#email_checked_handler'

  end

  root 'index/index#index'
  
  namespace :manage do
    resources :admins 
    resources :roles
    resources :nodes,only: [:index]
    resources :configs,only: [:index,:edit,:update]
    resources :contests do 
      delete 'recover' => 'contests#recover'
    end

    get 'xform_render'=> 'sections#xform_render'  
    resources :competes do
      resources :sections, except:[:index]
    end

    get 'news/news_list'
    resources :news do
      delete 'recover'
      delete 'hard_delete'
    end
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
