Cookbook::Application.routes.draw do
  match 'recipes' => 'recipes#index', :as => :recipes
  match 'recipes/all' => 'recipes#all', :as => :all_recipes
  match 'recipes/new' => 'recipes#new', :as => :new_recipe
  match 'login/index' => 'login#index', :as => :login

  resources :recipes

  root :to => "recipes#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  match ':controller(/:action(/:id(.:format)))'
end
