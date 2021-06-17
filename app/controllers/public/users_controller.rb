class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only:[:show, :edit, :update, :unsubscribe, :withdraw]
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @lists = @user.lists.page(params[:page]).reverse_order
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:primary] = "ユーザ情報を更新しました"
      redirect_to mypage_path(@user)
    else
      render 'edit'
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @user.update(is_deleted: true)
    reset_session
    flash[:danger] = "退会処理が完了しました。またのご利用を心よりお待ちしております。"
    redirect_to request.referer
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to mypage_path(current_user)
    end
  end
end
