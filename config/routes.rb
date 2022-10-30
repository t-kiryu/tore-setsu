Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get   'about' => 'homes#about'
    get   'customers/my_page'         => 'customers#show'
    get   'customers/infomation/edit' => 'customers#edit'
    patch 'customers/infomation'      => 'customers#update'
    get   'customers/unsubscribe'     => 'customers#unsubscribe'
    patch 'customers/withdrawal'      => 'customers#withdrawal'
    get   'customers/:id/bookmark'    => 'customers#bookmark', as: 'bookmarks'
    get   'customers/:id/my_post'     => 'customers#my_post', as: 'my_posts'

    # 投稿確認画面の実装中止（post 'posts/confirm' => 'posts#confirm'）
    # 投稿にコメント、ブックマークを行うため親子関係(ネスト)
    resources :posts, only: [:new, :create, :index, :show, :edit, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root to: 'posts#index'
    get 'customers/:id/bookmark'    => 'customers#bookmark', as: 'bookmarks'
    get 'customers/:id/my_post'     => 'customers#my_post', as: 'my_posts'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :tags,      only: [:index, :create, :edit, :update, :destroy]
    resources :posts,     only: [:index, :show, :edit, :update, :delete] do
      resources :post_comments, only: [:edit, :update]
    end
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
