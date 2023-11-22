# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do

  User.create!(
    email: Faker::Internet.email,
  encrypted_password: Devise.friendly_token[0, 20], # ダミーのパスワードを生成
  provider: 'sns_provider', # 適切なSNSのプロバイダを指定
  uid: 'sns_uid', # SNSのUIDを指定
  name: Faker::Name.first_name
)

20.times do |repertoire|
	Board.create(
		user: User.offset(rand(User.count)).first,
		name: "レシピ名#{repertoire}",
		recipe_url: "レシピのURL#{repertoire}"
	)
end