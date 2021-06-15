class Admin::ListCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    ListComment.find_by(id: params[:id], list_id: params[:list_id]).destroy
    flash[:danger] = "コメントを削除しました"
    redirect_to edit_admin_list_path(params[:list_id])
  end
end
