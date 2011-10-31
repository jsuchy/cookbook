Cookbook::Application.routes.draw do
  resources :recipes
  match 'recipes/all' => 'recipes#all', :as => :all_recipes
  match 'recipes/search' => 'recipes#search', :as => :search_recipes

  match 'login/index' => 'login#index', :as => :login
  match 'login/attempt_login' => 'login#attempt_login'
  match 'logout' => 'login#logout'

  root :to => "recipes#index"
end
