Rails.application.routes.draw do
  resources :subjects, only: [:create], param: :token do
    resources :chats, only: [:create] do
      resources :messages, only: [:create]
    end
  end
end
