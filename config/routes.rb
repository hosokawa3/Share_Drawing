Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get '/about' => "homes#about"
    # resources :end_users, only: [:show, :edit]
    get 'end_users/mypage' => 'end_users#show', as: 'mypage'
    get 'end_users/information/edit' => 'end_users#edit', as: 'edit_information'
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
