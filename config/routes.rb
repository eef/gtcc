Rcorp::Application.routes.draw do
  
  resources :profiles

  resources :setting_types

  resources :settings

  resources :setup_groups

  resources :tunings

  get "garage/index"

  resources :owned_cars

  resources :upgrades
  
  resources :garage

  resources :upgrade_groups

  resources :races

  resources :cars

  resources :manufacturers

  resources :track_types

  resources :locations

  resources :tracks

  devise_for :users

  root :to => "home#index"
  
  match "/tunings/car/:id" => "tunings#index"
  match "/setup" => "home#setup"
  match "/save_setup" => "home#save_setup"
  match "/account" => "account#index"
  match "/account/edit" => "account#edit"
  match "/account/update" => "account#update"
  match "/site" => "site#show"
  match "/site/edit" => "site#edit"
  match "/site/update" => "site#update"
  match "/race/enter/:id", :to => "races#enter_race", :as => "enter_race"
  match "/race/exit/:id", :to => "races#exit_race", :as => "exit_race"
  
end
