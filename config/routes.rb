Rails.application.routes.draw do
  resources :profiles, only: [:show, :edit]
  devise_for :users, controllers: { confirmations: 'confirmations', :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'static_page/home_page'

  get 'static_page/about'

  get 'static_page/contact'

  root 'static_page#home_page'

end
