Cat99::Application.routes.draw do
  resources :users

  resources :cats do
    resources :cat_rental_requests, only: :index
  end
  resources :cat_rental_requests, only: [:create, :new] do
      post "approve", on: :member
      post "deny", on: :member
  end

  resource :session

end
