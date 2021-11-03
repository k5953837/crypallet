Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/:id/balance', to: 'users#balance'
      post 'users/:id/deposit', to: 'users#deposit'
      post 'users/:id/transfer', to: 'users#transfer'
      post 'users/:id/withdraw', to: 'users#withdraw'
    end
  end
end
