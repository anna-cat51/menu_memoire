# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 10.times do

#   User.create!(
#   email: Faker::Internet.email,
#   encrypted_password: Devise.friendly_token[0, 20], # ダミーのパスワードを生成
#   provider: 'sns_provider', # 適切なSNSのプロバイダを指定
#   uid: 'sns_uid', # SNSのUIDを指定
#   name: Faker::Name.first_name
#   )
# end
# Deviseのヘルパーメソッドを使用してパスワードを暗号化
encrypted_password = User.new(password: 'password').encrypted_password

# ダミーのユーザーを作成
# 10.times do
#   user = User.create!(
#     email: Faker::Internet.email,
#     password: encrypted_password,
#     encrypted_password: encrypted_password,
#     name: Faker::Name.first_name,
#     # providerとuidは外部認証用なので、適宜値を設定（LINE認証を想定している場合）
#     provider: 'line',
#     uid: '1234567890'
#   )
# end
# puts "ダミーデータを作成したナ！"

# repertoire の数だけループ
20.times do |index|
  Repertoire.create!(
    user: User.offset(rand(User.count)).first,
    name: "レシピ名#{index}",
    recipe_url: "レシピのURL#{index}"
  )
end

ingredients = Ingredient.create!([
  { name: 'ひき肉'},
  { name: '玉ねぎ'},
  { name: 'にんじん'},
  { name: 'じゃがいも'},
  { name: '卵'},
  { name: 'ケチャップ'},
  { name: '鶏肉'},
  { name: '豚肉'},
  { name: 'キャベツ'},
  { name: 'カレールー'}
])

repertoire_ingredients_data = [
  { repertoire: Repertoire.first, ingredient: ingredients[0] },
  { repertoire: Repertoire.first, ingredient: ingredients[1] },
  { repertoire: Repertoire.first, ingredient: ingredients[4] },
  { repertoire: Repertoire.second, ingredient: ingredients[1] },
  { repertoire: Repertoire.second, ingredient: ingredients[2] },
  { repertoire: Repertoire.second, ingredient: ingredients[3] },
  { repertoire: Repertoire.second, ingredient: ingredients[7] },
  { repertoire: Repertoire.second, ingredient: ingredients[9] },
  # 以下同様に続く
]
RepertoireIngredient.create(repertoire_ingredients_data)
