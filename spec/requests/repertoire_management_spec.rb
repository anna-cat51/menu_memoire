require 'rails_helper'

RSpec.feature 'Repertoire Management', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new({
      provider: 'line',
      uid: '123',
      info: {
        nickname: 'anonymous'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token'
      }
    })

    visit user_line_omniauth_authorize_path(:line)
    # コールバックのパスをシミュレート
    visit user_line_omniauth_callback_path
  end

  after do
    OmniAuth.config.test_mode = false
  end

  scenario 'User adds a new repertoire' do
    # レパートリー追加ページへ遷移
    visit new_repertoire_path

    # フォームに情報を入力
    fill_in '料理名', with: '肉じゃが'
    fill_in '食材', with: '牛肉,玉ねぎ,しらたき,にんじん,じゃがいも'
    click_button '登録する'

    # レパートリーが追加されたことを確認
    expect(page).to have_content 'レパートリーを作成しました'
    expect(page).to have_content '肉じゃが'
  end
end
