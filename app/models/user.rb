class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[line]

  has_many :repertoires, dependent: :destroy

  enum status: {
    top: 0,
    waiting_for_choice: 1,
    waiting_for_input_for_repertoire: 2,
    waiting_for_input_for_ingredient: 3
  }

  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    credentials = omniauth['credentials']
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']

    credentials = omniauth['credentials']
    info = omniauth['info']

    access_token = credentials['refresh_token']
    access_secret = credentials['secret']
    credentials = credentials.to_json
    name = info['name']
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    save!
  end

  # Userのproviderがカラの場合のみPassword入力を要求する
  def password_required?
    super && provider.blank?
  end
end
