class Public::ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[show edit update destroy]

  def new
    @list = List.new
  end

  def index
    @lists = List.page(params[:page]).reverse_order
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      flash[:success] = "リストを投稿しました"
      redirect_to list_path(@list)
    else
      @lists = List.all
      render "new"
    end
  end

  def show
    @list_comment = ListComment.new
  end

  def edit
    if @list.user == current_user
      render "edit"
    else
      redirect_to lists_path
    end
  end

  def update
    if @list.update(list_params)
      flash[:primary] = "リストを更新しました"
      redirect_to list_path(@list)
    else
      render "edit"
    end
  end

  def destroy
    @list.destroy
    flash[:danger] = "リストを削除しました"
    redirect_to lists_path
  end

  def done
    @list.update(done: true)
    redirect_to list_path(@list)
  end

  private

  def list_params
    params.require(:list).permit(:first_item, :second_item, :third_item, :date, :done)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
