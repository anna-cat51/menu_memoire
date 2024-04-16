50.times do
  repertoire = Faker::Food.dish
  ingredient = Faker::Food.ingredient

  Repertoire.create(
    name: repertoire,
    user_id: 1
  )
end