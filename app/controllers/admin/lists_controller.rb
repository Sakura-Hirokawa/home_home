class Admin::ListsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @lists = List.all
    @user = User.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
    @user = User.find_by(id: @list.user_id)
  end

  def destroy
    @list = List.find(params[:id])
    @user = User.find_by(id: @list.user_id)
    @list.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to admin_user_path(@user)
  end
end
