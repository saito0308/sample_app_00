module SessionsHelper

#渡されたユーザーでログインする(log_inというヘルパーメゾットの定義)
 def log_in(user)
#セッション用の中のuser_idにログイン時自動生成されたuserのidを保存
  session[:user_id] = user.id
 end

#現在ログイン中のユーザーをかえす/いる場合(current_userの定義)
#userがログインしているかどうかを調べるメゾット
  def current_user
#session[:user_id]メゾット（もしuser.idが保存されていたら）
   if session[:user_id]
     @current_user || User.find_by(id: session[:user_id])
     end
  end

#ユーザーがログインしていればtrue,その他ならばfalseを返す(logged_in?メゾットの定義)
 def logged_in?
  !current_user.nil?
  end

#現在のユーザーをログアウトする
 def log_out
   session.delete(:user_id)
   @current_user = nil
   end
end
