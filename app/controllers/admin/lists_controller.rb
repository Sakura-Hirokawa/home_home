class Admin::ListsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_list, only: %i(edit update destroy)

  def show
    @lists = List.page(params[:page]).reverse_order
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find_by(id: @list.user_id)
  end

  def update
    @list.update(list_params)
    flash[:primary] = "リストを更新しました"
    redirect_to admin_list_path(@list)
  end

  def destroy
    @user = User.find_by(id: @list.user_id)
    @list.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to admin_user_path(@user)
  end

  private

  def list_params
    params.require(:list).permit(:first_item, :second_item, :third_item, :date, :done)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
