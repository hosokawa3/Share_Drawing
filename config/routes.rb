Rails.application.routes.draw do

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
