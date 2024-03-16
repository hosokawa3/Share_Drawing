class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.all.page(params[:page]).per(6)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
