class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(user_params)
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end
end
