module SessionsHelper

#渡されたユーザーでログインする(log_inというヘルパーメゾットの定義)
 def log_in(user)
#セッション用の中のuser_idにログイン時自動生成されたuserのidを保存
  session[:user_id] = user.id
 end

#ユーザーのセッションを永続的にする
def remember(user)
    user.remember
        cookies.permanent.signed[:user_id] = user.id
            cookies.permanent[:remember_token] = user.remember_token
              end

#渡されたユーザーがログイン済みユーザーであればtureを返す
def current_user?(user)
 user == current_user
end

def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
       if user && user.authenticated?(:remember,cookies[:remember_token])
          log_in user
          @current_user = user
             end
           end
        end

#ゆーザーがログインしていればtrue,その他ならばfalseを返す(logged_in?メゾットの定義)
 def logged_in?
  !current_user.nil?
  end

#永続セッションを破棄する
 def forget(user)
  user.forget
#クッキーに保存していたidとremenber_tokenを破棄する
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
end
#現在のユーザーをログアウトする
 def log_out
  forget(current_user)
   session.delete(:user_id)
   @current_user = nil
   end

#記憶URL(もしくはデフォルト値)にリダイレクト
 def redirect_back_or(default)
 redirect_to(session[:forwarding_url] || default)
 session.delete(:forwarding_url)
 end

#アクセスしようとしたURLを覚えておく
def store_location
 session[:forwarding_url] = request.original_url if request.get?
 end
end
