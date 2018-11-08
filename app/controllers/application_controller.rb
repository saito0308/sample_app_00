class ApplicationController < ActionController::Base
 protect_from_forgery with: :exception
#セッション用のヘルパーがここに記入することで、どのコントローラーでも使用できるようになる
 include SessionsHelper
end
