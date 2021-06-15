class Public::ListCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @list_comment = ListComment.new(list_comment_params)
    @list_comment.list_id = @list.id
    @list_comment.user_id = current_user.id
    @list_comment.save
    redirect_to list_path(@list)
  end

  def destroy
    ListComment.find_by(id: params[:id], list_id: params[:list_id]).destroy
    flash[:danger] = "コメントを削除しました"
    redirect_to list_path(params[:list_id])
  end

  private

  def list_comment_params
    params.require(:list_comment).permit(:comment)
  end
end
