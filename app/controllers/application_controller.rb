class ApplicationController < ActionController::Base
<<<<<<< HEAD
  add_flash_types :success, :info, :warning, :danger
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def require_login
    redirect_to login_path, warning: 'ログインしてください' if current_user.blank?
  end
  # エラー時の処理を定義するプライベートメソッド
  def record_not_found
    # ユーザーにエラーメッセージを表示する、または別のページにリダイレクトする
    flash[:alert] = 'このページは存在しないか、アクセスできません'
    redirect_to root_path # 例：ホームページにリダイレクト
  end
=======
>>>>>>> 0348fbfde0827f1a432af27f62fe22ff6c4c7113
end
