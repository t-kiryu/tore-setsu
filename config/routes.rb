Rails.application.routes.draw do

  scope module: :public do
    root to: 'posts#top'

    post 'post/confirm' => 'post#confirm'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update]
  end

  namespace :admin do
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
