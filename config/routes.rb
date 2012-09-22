OSP::Application.routes.draw do


  devise_for :admins do
    match 'admin' => 'devise/sessions#new'
    match 'sign_out' => 'devise/sessions#destroy'
  end

  root :to => 'pages#index'
  get "index" => 'pages#index', :as => 'pages_index'
  get "resources" => 'pages#resources', :as => 'pages_resources'
  get "writing_tips" => 'pages#writing_tips', :as => 'pages_writing_tips'
  get "about" => 'pages#about', :as => 'pages_about'

  resources :stories
  match "random_story" => "stories#random"
  resources :comments, :not => [:edit, :destroy, :update]
  
  get 'contact' => "general_mailer#contact"
  post 'contact' => "general_mailer#send_contact_us"

  namespace :admin do
    get "unapproved_stories" => "stories#unapproved"
    get "approved_stories" => "stories#approved"
    get "approve_story" => "stories#approve"
    get "disapprove_story" => "stories#disapprove"
    get "stories_with_unapproved_comments" => "stories#with_unapproved_comments"
    get "approve_comment" => "comments#approve"
    get "disapprove_comment" => "comments#disapprove"
    resources :comments, :only => [:edit, :destroy, :update]
    get "settings/resources"
    get "settings/settings"
    post "pages/resources" => "pages#update_resources"
    resources :settings
    resources :stories, :only => [:destroy, :edit, :update]
  end

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
