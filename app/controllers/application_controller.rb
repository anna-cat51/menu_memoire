class ApplicationController < ActionController::Base
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> adcbcae (Revert "Flash massages")
  add_flash_types :success, :info, :warning, :danger
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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
=======
>>>>>>> 9108fe7 (Revert "Flash massages")
<<<<<<< HEAD
=======
>>>>>>> 9108fe7 (Revert "Flash massages")
=======
>>>>>>> adcbcae (Revert "Flash massages")
end
