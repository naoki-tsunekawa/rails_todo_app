class ApplicationController < ActionController::Base
  # 全てのコントローラーからセッションに保管されているログイン情報を利用できるようにする
  # helper_method :current_user
  before_action :current_user


  private

  def current_user
    # セッションにログイン情報がある場合、@current_userにユーザ情報を格納する
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    end 
  end
end
