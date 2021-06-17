class Public::ListCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @list_comment = ListComment.new(list_comment_params)
    @list_comment.list_id = @list.id
    @list_comment.user_id = current_user.id
    @list_comment.save
  end

  def destroy
    @list = List.find(params[:list_id])
    list_comment = @list.list_comments.find(params[:id])
    list_comment.destroy
  end

  private

  def list_comment_params
    params.require(:list_comment).permit(:comment)
  end
end
