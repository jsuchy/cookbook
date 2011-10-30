Cookbook::Application.routes.draw do
  match 'recipes/all' => 'recipes#all', :as => :all_recipes
  match 'login/index' => 'login#index', :as => :login
  match 'login/attempt_login' => 'login#attempt_login'
  match 'logout' => 'login#logout'
  match 'recipes/search' => 'recipes#search'

  resources :recipes

  root :to => "recipes#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  #match ':controller(/:action(/:id(.:format)))'
end
