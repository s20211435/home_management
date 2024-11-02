class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now.notice = "ユーザー登録に成功しました"
    else
      render :new # または他の適切なアクション
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now.notice = "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_url, notice: "ユーザーの削除に成功しました"
    else
      Rails.logger.error(@user.errors.full_messages) # エラーメッセージをログに出力
      redirect_to users_url, alert: "ユーザーの削除に失敗しました"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
