Rcorp::Application.routes.draw do
  
  resources :leagues

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

  devise_for :users, :controllers => {:registrations => "registrations"}

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
  match "/race/exit/:id/:user_id", :to => "races#exit_race", :as => "admin_exit_race"
  match "/league/enter/:id/:lc_id", :to => "leagues#enter_league", :as => "enter_league"
  match "/league/enter_nocc", :to => "leagues#enter_league", :as => "enter_league"
  match "/league/exit/:id", :to => "leagues#exit_league", :as => "exit_league"
  match "/league/exit/:id/:user_id", :to => "leagues#exit_league", :as => "admin_exit_league"
  match "/race/gen_results/:id", :to => "races#generate_results", :as => "generate_results"
  match "/league/post_discussion", :to => "leagues#post_discussion", :as => "post_discussion"
  match "/races/new/:league_id", :to => "races#new", :as => "new_league_race"
  match "/find_car", :to => "cars#find_car"
  
end
