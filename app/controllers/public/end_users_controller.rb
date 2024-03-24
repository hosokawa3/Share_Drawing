class Public::EndUsersController < ApplicationController
  before_action :ensure_guest_end_user, only: [:edit]
  before_action :authenticate_end_user!
  before_action :is_matching_login_end_user, only: [:edit, :update]

  def show
    @end_user = EndUser.find(params[:id])
    #ユーザーごとに投稿作品を新着順に4件取得する
    @posts = Post.where(end_user_id: @end_user).order(created_at: :desc).limit(4)
    #DM機能
    @current_entry = Entry.where(end_user_id: current_end_user.id)
    @another_entry = Entry.where(end_user_id: @end_user.id)
    unless @end_user.id == current_end_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
    unless @is_room
      @room = Room.new
      @entry = Entry.new
    end
    end
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def check
  end

#論理削除
  def withdraw
    end_user = EndUser.find(current_end_user.id)
    end_user.update(is_active: false)
    reset_session
    redirect_to root_path, flash: {success: "退会処理を実行いたしました"}
  end

  #いいねした投稿一覧
  def favorites
    @end_user = EndUser.find(params[:id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @posts = Kaminari.paginate_array(Post.find(favorites)).page(params[:page]).per(8)
  end

  #ユーザーごとの投稿一覧
  def index_posts
    @end_user = EndUser.find(params[:id])
    @posts = Post.where(end_user_id:params[:id]).page(params[:page]).per(8)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.guest_end_user?
      redirect_to profile_path(current_end_user) , flash: {warning: "ゲストユーザーはプロフィール編集画面へ遷移できません。"}
    end
  end

  def is_matching_login_end_user
    end_user = EndUser.find(params[:id])
    unless end_user.id == current_end_user.id
      redirect_to profile_path(current_end_user)
    end
  end

end
