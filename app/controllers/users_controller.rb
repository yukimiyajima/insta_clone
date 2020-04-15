class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id]) 
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ブログを編集しました！"
    else
      render :edit
    end
  end
  def user_favorites
    @user = User.find(params[:id])
    @blog = Blog.where(user_id: @user.id)
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end