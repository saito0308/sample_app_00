class SessionsController < ApplicationController
  def new
  end

def create
#userはセッションの中で入力されたemailを小文字(downcase)にして取得する(paramsで取得)/取得したメールアドレスがデータベースに存在するかを確認(User.find_by ユーザーデータベースで見つける)
   @user = User.find_by(email: params[:session][:email].downcase)

#もしuser(取得したセッションのメールアドレス)と取得したパスワードがどちらも存在していたら
#authenticateメゾット＝has_secure_passwordを定義して使えるメゾット。認証に失敗したらfalseを返す
   if @user && @user.authenticate(params[:session][:password])
     log_in @user
#永続ログインのチェックボックスがオンの時は１、オフの時は０になる
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      #ユーザーログイン後にユーザー情報のページにリダイレクト（勝手に飛ぶ）
      #redirect_user = （rails自動変換）user_url(user)/各ユーザーページに飛ぶ
     redirect_to @user
   else
#nowはその後リクエストが発生した時に消滅（何か更新が会った時）
    flash.now[:danger] = 'Invalid email/password combination'
#エラーメッセージを作成する
   render 'new'
   end
end

  def destroy
   log_out if logged_in?
   redirect_to root_url
  end
end
