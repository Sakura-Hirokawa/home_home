class Public::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy]

  def new
    @event = Event.new
  end

  def index
    @events = Event.where(user_id: current_user.id)
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = "スケジュールを登録しました"
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def show; end

  def edit
    redirect_to root_path unless @event.user == current_user
  end

  def update
    if @event.update(event_params)
      flash[:primary] = "スケジュールを更新しました"
      redirect_to event_path(@event)
    else
      render "edit"
    end
  end

  def destroy
    @event.destroy
    flash[:danger] = "スケジュールを削除しました"
    redirect_to my_calendar_path
  end

  def my_calendar; end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:user_id, :title, :description, :start_at, :end_at)
  end
end
