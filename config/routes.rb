Rails.application.routes.draw do
  constraints(Subdomain) do
    scope module: :storefronts, path: '', as: 'storefronts', subdomain: true do
      resources :products, only: [:index, :edit, :destroy], as: 'products'
      get '/signin', to: 'storefronts#signin', as: 'signin'
    delete '/signout', to: 'storefronts#signout', as: 'signout'
    end
    root to: 'storefronts#show'
  end
  
  # root to: 'statics#index'
  
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  %w( 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 421 422 423 424 425 426 428 429 431 451 500 501 502 503 504 505 506 507 508 510 511 ).each do |code|
    get "/#{code}", to: "errors#show", code: code
  end
end