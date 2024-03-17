class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = Post.ransack(title_or_end_user_name_cont: params[:title_or_end_user_name_cont])
    if params[:title_or_end_user_name_cont].present?
      @posts = @q.result(distinct: true).page(params[:page]).per(8)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)
    end

    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(8)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(8)
    elsif params[:most_favorited]
      @posts = Kaminari.paginate_array(Post.most_favorited).page(params[:page]).per(8)
    else
      unless params[:title_or_end_user_name_cont].present?
        @Posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
end
