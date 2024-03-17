class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    #受け取った値を,で区切って配列にする
    tags = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tags(tags)
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @tags = Tag.all
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
    @post_comment = PostComment.new
    @tags = @post.tags.pluck(:tag_name).join(',')
    @post_tags = @post.tags
    #一度閲覧したユーザーを数えない(１日１回)
    unless ViewCount.where(created_at: Time.zone.now.all_day).find_by(end_user_id: current_end_user.id, post_id: @post.id)
      current_end_user.view_counts.create(post_id: @post.id)
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:tag_name).join(',')
  end

  def update
    post = Post.find(params[:id])
    tags = params[:post][:tag_name].split(',')
    post.update(post_params)
    post.save_tags(tags)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search_tag
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(8)
  end

  private

  def post_params
    params.require(:post).permit(:title, :caption, :image)
  end
end
