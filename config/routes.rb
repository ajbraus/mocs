Mocs::Application.routes.draw do

  resources :messages
  resources :posts, path: 'Mocs'

  root :to => 'posts#index'
  match '/how', :to => 'welcome#how', :as => "how"
  match '/about', :to => 'welcome#about', :as => "about"

  devise_for :users, :controllers => { :registrations => "registrations" }
  
  match 'users/:id/profile/edit' => 'profiles#edit', as: 'edit_profile'
  match 'users/:id/profiles' => 'profiles#update', as: 'update_profile'


  resources :comments do
    member do
      get :vote_up
      get :vote_down
    end
  end

  resources :users, :only => [:show, :index, :confirm, :reject] do
    get :reject
    get :confirm
  end
  match 'users/:id' => 'users#show'
  match 'user/projects', to: "users#posts", as: "user_posts"
  match '/org_name', :to => 'users#org_name', :as => "org_name"
  
  match 'organizations/:id' => 'organizations#show'

  resources :commitments, only: [:create, :destroy] do 
    member do
      put :increment_progress
      put :decrement_progress
    end
  end

  get 'specialities/:speciality', to: 'specialities#show', as: :speciality

  # namespace :api do
  #   namespace :v1 do
  #     match '/home', to: 'welcome#index', as: 

  #   end
  # end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
