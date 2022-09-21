Rails.application.routes.draw do

  scope module: :public do
    root to: 'posts#top'
    get   'customers/my_page'         => 'customers#show'
    get   'customers/infomation/edit' => 'customers#edit'
    patch 'customers/infomation'      => 'customers#update'
    get   'customers/unsubscribe'     => 'customers#unsubscribe'
    patch 'customers/withdrawal'      => 'customers#withdrawal'
    post 'posts/confirm' => 'posts#confirm'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :create, :edit, :update]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
