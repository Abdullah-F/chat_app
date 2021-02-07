Rails.application.routes.draw do
  resources :subjects, only: [:create], param: :token do
    resources :chats, only: [:create, :destroy], param: :order do
      resources :messages, only: [:create, :update, :destroy], param: :order
    end
  end
end
