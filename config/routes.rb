Rails.application.routes.draw do
  resources :subjects, only: [:create], param: :token do
    resources :chats, only: [:create], param: :order do
      resources :messages, only: [:create, :update]
    end
  end
end
