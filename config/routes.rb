Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get '/about' => "homes#about"
    get 'end_users/profile/:id' => 'end_users#show', as: 'profile'
    get 'end_users/information/edit/:id' => 'end_users#edit', as: 'edit_information'
    patch 'end_users/information/:id' => 'end_users#update', as: 'update_information'
    resources :posts, only: [:new, :index, :show, :edit, :create]
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
