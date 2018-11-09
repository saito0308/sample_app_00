class UsersController < ApplicationController


def show
 @user = User.find(params[:id])
end


def new
  @user = User.new
  end


#ユーザー新規登録
def create
  @user = User.new(user_params)
   if @user.save
#登録したユーザーをそのままログインさせておく
     log_in @user
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user
      #もし保存に成功したら
     else
      render 'new'
    end
   end





   private

    def user_params
     params.require(:user).permit(:name,:email,:password,
     :password_confirmation)
   end
end
