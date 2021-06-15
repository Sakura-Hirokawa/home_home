class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:success] = "ユーザ情報を更新しました"
    redirect_to  admin_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :is_deleted)
  end
end
