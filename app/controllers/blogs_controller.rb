class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @blogs = Blog.all
  end

  def new
    @blog = current_user.blogs.build
  end

  def confirm
    # @blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def create
    # @blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    elsif @blog.save
      # BlogMailer.blog_mail(@blog).deliver
      redirect_to blogs_path, notice: "投稿しました！"
    else
      render :new
    end
  end

  def show
    # @blog = Blog.find(params[:id]) 
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    @blog = Blog.find(params[:id]) 
  end

  def update
    @blog = Blog.find(params[:id]) 
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"投稿を削除しました！"
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end
  def set_blog
    @blog = Blog.find(params[:id])
  end
  def ensure_correct_user
    if current_user.id != @blog.user.id
      flash[:notice] = "編集権限がありません"
      redirect_to blogs_path
    end
  end
  end