Rails.application.routes.draw do



  devise_for :teams
  get 'home/index'

  root to: "home#index"

  # get '/sessions/destroy' => 'sessions#destroy'
  get '/about' => 'home#about'

  get '/admin' => 'admin#index'
  get '/admin/manage_teams/:simulation_id' => 'admin#manage_teams'
  post '/input_screen/update_decision_field' => 'input_screens#update_decision_field'
  # get '/simulations/:simulation_id/edit_intro_text' => 'simulations#edit_intro_text'

  get '/teams/:simulation_id/new' => 'teams#new'
  resources :teams
  # resources :sessions
  resources :simulations do
    member do
      get 'edit_intro_text'
      get 'enable_final_reports'
    end
  end
  resources :rounds do
    member do
      get 'enable'
    end
  end
  resources :input_screens
  post '/pusher/auth' => 'pusher#auth'
  get 'test_input_form' => 'input_screens#test_input_form'

  get 'round/:id' =>  'rounds#show_round'

  get '/team/export/:team_round_id' => 'teams#export'
  get "/team/reports/:team_round_id" => 'team_rounds#reports'

  post '/input_screen/update_decision' => 'input_screens#submit_decision'

  get 'round/:round_id/input_screen/:input_screen_id' => 'input_screens#show_input_screen'

  post '/input_screen/update' => 'input_screens#update_input_screen_info'
  get '/team_round/:team_round_id/submit_decisions' => 'team_rounds#submit_decisions'
  post '/team_round/:team_round_id/add_report' => 'team_rounds#add_report'
  post '/team_round/:team_round_id/add_graph_data' => 'team_rounds#add_graph_data'
  post 'round/:round_id/add_economic_data' => 'rounds#add_economic_data'
  post 'round/:round_id/add_debrief' => 'rounds#add_debrief'
  post '/input_screen/:input_screen_id/submit_decisions' => 'input_screens#submit_decisions'
  post '/simulation/:simulation_id/add_opening_report' => 'simulations#add_opening_report'
  post '/simulation/:simulation_id/add_debrief' => 'simulations#add_debrief'
  post '/simulation/:simulation_id/add_economic_data' => 'simulations#add_economic_data'
  post '/teams/sign_up' => 'teams#sign_up'
  get '/home/welcome' => 'home#welcome'
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
