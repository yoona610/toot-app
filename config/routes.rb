Rails.application.routes.draw do
  #deviseのルーティング
  devise_for :admins,
    path: :admin,
    controllers: {
      sessions: 'admin/devise/sessions',
      passwords: 'admin/devise/passwords',
      registrations: 'admin/devise/registrations',
    }

  devise_for :users,
    controllers: {
      sessions: 'public/devise/sessions',
      passwords: 'public/devise/passwords',
      registrations: 'public/devise/registrations',
    }

  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/devise/sessions#guest_sign_in'
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/devise/sessions#guest_sign_in'
  end

  #publicのルーティング
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]
  end

  #adminのルーティング
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
