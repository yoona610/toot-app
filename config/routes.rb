Rails.application.routes.draw do
  #deviseのルーティング
  devise_for :users,
    controllers: {
      sessions: 'public/devise/sessions',
      passwords: 'public/devise/passwords',
      registrations: 'public/devise/registrations',
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
