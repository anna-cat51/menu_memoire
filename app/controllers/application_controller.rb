class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :auto_login_in_development
  before_action :set_search

  private

  def require_login
    redirect_to root_path, warning: 'ログインしてください' if current_user.blank?
  end

  # エラー時の処理を定義するプライベートメソッド
  def record_not_found
    # ユーザーにエラーメッセージを表示する、または別のページにリダイレクトする
    flash[:alert] = 'このページは存在しないか、アクセスできません'
    redirect_to root_path # 例：ホームページにリダイレクト
  end

  def auto_login_in_development
    return unless Rails.env.development?

    # ここで指定したユーザーでログインします。
    # 例えば、最初のユーザーでログインする場合:
    user = User.first
    sign_in(user) if user
  end

  def set_search
    @search = Search.new(word: params[:word])
  end
end
