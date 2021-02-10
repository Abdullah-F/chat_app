Rails.application.routes.draw do
  resources :subjects, only: [:create, :index], param: :token do
    resources :chats, only: [:create, :destroy, :show], param: :order do
      resources :messages, only: [:create, :update, :destroy], param: :order
      member do
        get :search
      end
    end
  end
end
