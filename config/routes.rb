Rails.application.routes.draw do
  resources :subjects, only: [:create]
end
