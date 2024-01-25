class SessionsController < Devise::SessionsController
  def destroy
    # ログアウト処理のメソッド
    sign_out current_user
    redirect_to root_path, notice: t('.notice')
  end
end
