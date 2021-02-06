Rails.application.routes.draw do
  resources :subjects, only: [:create], param: :token do
    resources :chats, only: [:create]
  end
end
