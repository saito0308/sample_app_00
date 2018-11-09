require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

def setup
#テスト用アカウントを使用
 @uesr = users(:michael)
 end

#ユーザー情報の更新に失敗した時のテスト
 test "unsuccessful edit" do
#ユーザー編集ページを開く
  get edit_user_path(@user)
#編集ページのHTMLが表示されているか確認
  assert_template 'users/edit'
#提出された情報が不適切なもの
  patch user_path(@user),params:{ user: { name: "",
                                 email: "foo@invalid",
                                 password:    "foo",
                                 password_confirmation: "bar" } }
#別ベージに移動しないで編集画面のまま止まっているかの確認
 assert_template 'users/edit'
  end
end
