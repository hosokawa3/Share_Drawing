class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    #投稿作品を新着順に4件取得する
    @posts = Post.order(created_at: :desc).limit(4)
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

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end
end
