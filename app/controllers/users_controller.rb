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

#ユーザー情報の編集ページ
 def edit
#ログインしているユーザーの情報をidで引っこ抜いてくる
  @user = User.find(params[:id])
end

#ユーザー情報更新
def update
#更新したユーザーのデータを取得
 @user = User.find(params[:id])
  if @user.update_attributes(user_params)
#更新に失敗した場合を扱う(ex.パスワードが６桁以下だったとか)
    else
#ページを移動させないでそのまま編集ページを表示
       render 'edit'
 end
end





   private

    def user_params
     params.require(:user).permit(:name,:email,:password,
     :password_confirmation)
   end
end
