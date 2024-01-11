require 'rails_helper'

describe "line login test" do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new({
        provider: 'line',
        uid: '123',
        info: {
            nickname: 'anonymous'
        },
        credentials: {
            token: "mock_token",
            refresh_token: "mock_refresh_token"
        }
    })

    visit user_line_omniauth_authorize_path(:line)
    # コールバックのパスをシミュレート
    visit user_line_omniauth_callback_path
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe "after login" do
    it "should display the page for debugging" do
        save_and_open_page
    end
    it { expect(page).to have_link('ログアウト') }
    # ログイン成功のメッセージが表示されることを確認
    it { expect(page).to have_content('ログインしました。') }
  end
end
