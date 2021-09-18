Rails.application.routes.draw do
  root to: 'public/homes#top'

  # deviseのルーティング
  devise_for :admins,
             path: :admin,
             controllers: {
               sessions: 'admin/devise/sessions',
               passwords: 'admin/devise/passwords',
               registrations: 'admin/devise/registrations'
             }

  devise_for :users,
             controllers: {
               sessions: 'public/devise/sessions',
               passwords: 'public/devise/passwords',
               registrations: 'public/devise/registrations'
             }

  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/devise/sessions#guest_sign_in'
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/devise/sessions#guest_sign_in'
  end

  # publicのルーティング
  scope module: :public do
    get 'about' => 'homes#about'

    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    get 'search' => 'searches#index', as: 'public_index'
    get 'posts/search' => 'posts#search', as: 'category_index'
    get 'posts/rankings' => 'rankings#index'

    resources :users, only: %i[show edit update] do
      member do
        get :follows, :followers
      end
      resource :relationships, only: %i[create destroy]
    end
    resources :posts do
      resource :likes, only: %i[create destroy]
      resource :bookmarks, only: %i[create destroy]
      resources :comments, only: %i[create destroy]
    end
    resource :chats, only: %i[show create]
    resources :chat_rooms, only: [:update]
    resources :activities, only: [:index] do
      patch :read, on: :member
    end
  end

  # adminのルーティング
  namespace :admin do
    get 'search' => 'searches#index', as: 'index'
    resources :users, only: %i[index show edit update]
    resources :posts, only: %i[index show destroy]
    resources :categories, only: %i[index create edit update destroy]
    resources :chats, only: %i[index show create]
    resources :activities, only: [:index] do
      patch :read, on: :member
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
