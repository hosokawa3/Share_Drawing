class Public::EndUsersController < ApplicationController
  before_action :ensure_guest_end_user, only: [:edit]

  def show
    @end_user = EndUser.find(params[:id])
    #ユーザーごとに投稿作品を新着順に4件取得する
    @posts = Post.where(end_user_id: @end_user).order(created_at: :desc).limit(4)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to profile_path
  end

  def check
  end

#論理削除
  def withdraw
    end_user = EndUser.find(current_end_user.id)
    end_user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def favorites
    @end_user = EndUser.find(params[:id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end

  def index_posts
    @end_user = EndUser.find(params[:id])
    @posts = Post.where(end_user_id:params[:id])
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.guest_end_user?
      redirect_to profile_path(current_end_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
