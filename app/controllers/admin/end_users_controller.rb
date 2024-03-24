class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.all.page(params[:page]).per(5)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    end_user = EndUser.find(params[:id])
    end_user.update(end_user_params)
    redirect_to admin_end_user_path(end_user.id)
  end

  #ユーザーごとの投稿一覧
  def index_posts
    @end_user = EndUser.find(params[:id])
    @posts = Post.where(end_user_id:params[:id]).page(params[:page]).per(8)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email, :is_active)
  end
end
