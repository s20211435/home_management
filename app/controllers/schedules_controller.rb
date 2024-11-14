class SchedulesController < ApplicationController
  before_action :authentication_user!
  before_action :set_user

  def index
    @user = current_user
    @schedules = @user.schedules.page(params[:page]).per(10) # 1ページあたり10件表示
  end

  def new
    @schedule = Schedule.new
  end

def create
  @schedule = @user.schedules.build(schedule_params)
  if @schedule.save
    flash.now[:success] = "スケジュールを登録しました。"
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to user_schedules_path(@user), notice: 'スケジュールを登録しました' }
    end
  else
    flash.now[:alert] = 'スケジュールの登録に失敗しました'
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_schedule_frame", partial: "form", locals: { f: @schedule }) }
      format.html { render :new }
    end
  end
end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to schedules_path, notice: 'スケジュールを更新しました' }
      end
    else
      flash.now[:alert] = 'スケジュールの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id]) # ネストされた親リソースのユーザーを取得
    @schedule = @user.schedules.find(params[:id]) # ユーザーのスケジュールを特定
    @schedule.destroy
    redirect_to user_schedules_path(@user), notice: 'スケジュールを削除しました'
    flash.now[:alert] = 'スケジュールの削除に失敗しました' if @schedule.destroyed?
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :description, :start_time, :end_time)
  end

  def authentication_user!
    redirect_to new_session_path, alert: 'ログインしてください' unless current_user
  end

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
