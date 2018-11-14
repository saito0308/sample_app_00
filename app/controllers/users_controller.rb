class UsersController < ApplicationController
 before_action :logged_in_user, only:[:index,:edit,:update,:destroy]
 before_action :correct_user, only: [:edit,:update]
 before_action :admin_user, only: :destroy

def index
 @users = User.paginate(page: params[:page])
 end

def show
 @user = User.find(params[:id])
 @microposts = @user.microposts.paginate(page: params[:page])
end


def new
  @user = User.new
  end


#ユーザー新規登録
def create
  @user = User.new(user_params)
   if @user.save
#登録したユーザーをそのままログインさせておく
     @user.send_activation_email
     flash[:info] = "Please check your email to activate your account."
     redirect_to root_url
      #もし保存に成功したら
     else
      render 'new'
    end
  end

#ユーザー情報の編集ページ
 def edit
end

#ユーザー情報更新
def update
  if @user.update_attributes(user_params)
#更新に成功したら更新成功のフラッシュを表示
    flash[:success] = "Profile updated"
    redirect_to @user
#更新に失敗した場合を扱う(ex.パスワードが６桁以下だったとか)
    else
#ページを移動させないでそのまま編集ページを表示
       render 'edit'
 end
end

def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end





   private

    def user_params
     params.require(:user).permit(:name,:email,:password,
     :password_confirmation)
   end

#正しいユーザーかどうか確認
def correct_user
 @user = User.find(params[:id])
 redirect_to(root_url) unless current_user?(@user)
end

#管理者かどうか確認
def admin_user
 redirect_to(root_url) unless current_user.admin?
 end
end
