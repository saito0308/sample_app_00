require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

def setup 
  @user = users(:michael)
end


 test "login with invalid information" do
  get login_path
#指定されたテンプレート(sessions/new,HTML）が表示されているかを検証
  assert_template 'sessions/new'
#ログインページに空のemailとpasswordを取得（params)し、POST
  post login_path,params:{ session:{email:"",password: ""}}
#新しいセッションのフォーム（ページ/この段階ではページ移動無し）が再度表示される。
  assert_template 'sessions/new'
#メールとパスワードが空なので、フラッシュメッセージが追加されていることを確認
#assert_not 否定形にempty?なので「空ではない」＝追加されているの意
  assert_not flash.empty?
#別のページ（root_path/ホーム）に一旦移動（パスをgetして移動）
  get root_path
#移動先のページでフラッシュメッセージが表示されていないことを確認する/assertとempty?なので空かどうかの確認
  assert flash.empty?
 end

 test "login with valid information" do
#ログイン用のパスを開く
  get login_path
#セッション用パスに有効な情報をpost/@userはfixtureで定義したmichael
  post login_path,params:{ session:{ email: @user.email,
                             password: 'password'}}
 assert_redirected_to @user
#follow_redirect!=POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動する(:michaelの情報を取得してmichaelのユーザーページに移動する)
 follow_redirect!
 assert_template 'users/show'
#ログイン用のリンクが表示されていないことの確認
 assert_select "a[href=?]",login_path,count: 0
#ログアウト用のリンクが表示されていることの確認
 assert_select "a[href=?]",logout_path
#プロフィール用リンクが表示されていることの確認
 assert_select "a[href=?]",user_path(@user)
  end

test "login with valid information followed by logout" do
 get login_path

end

