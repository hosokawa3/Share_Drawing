Rails.application.routes.draw do

  namespace :admin do
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    get '/post_comments' => 'post_comments#index'
    get 'end_users/index_posts/:id' => 'end_users#index_posts', as: 'index_posts_end_user'
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => "homes#about"
    get 'end_users/profile/:id' => 'end_users#show', as: 'profile'
    get 'end_users/information/edit/:id' => 'end_users#edit', as: 'edit_information'
    patch 'end_users/information/:id' => 'end_users#update', as: 'update_information'
    get 'end_users/check' => 'end_users#check'
    patch 'end_users/withdraw' => 'end_users#withdraw'
    get 'end_users/favorites/:id' => 'end_users#favorites', as: 'favorites_end_user'
    get 'end_users/index_posts/:id' => 'end_users#index_posts', as: 'index_posts_end_user'
    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
    get 'search_tag' => 'posts#search_tag'
  end

  #管理者側
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  #エンドユーザー側
  devise_for :end_users, skip: [:passwords] ,controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲストログイン
  devise_scope :end_user do
    post "end_users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
