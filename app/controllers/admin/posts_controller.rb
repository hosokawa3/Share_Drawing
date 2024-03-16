class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
     @q = Post.ransack(params[:q])
    if params[:q].present?
      @posts = @q.result(distinct: true)
    else
      @posts = Post.all
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
