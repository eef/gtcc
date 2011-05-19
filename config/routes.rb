Rcorp::Application.routes.draw do
  
  devise_for :users

  root :to => "home#index"
  
  match "/setup" => "home#setup"
  match "/save_setup" => "home#save_setup"
  match "/account" => "account#index"
  match "/account/edit" => "account#edit"
  match "/account/update" => "account#update"
  match "/site" => "site#show"
  match "/site/edit" => "site#edit"
  match "/site/update" => "site#update"
  
end
