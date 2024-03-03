Rails.application.routes.draw do

  # namespace :public do
    # get 'homes/top'
    # get 'homes/about'
  # end
  # namespace :public do
    # get 'end_users/show'
    # get 'end_users/edit'
  # end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => "homes#about"
    resources :end_users, only: [:show, :edit]
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
