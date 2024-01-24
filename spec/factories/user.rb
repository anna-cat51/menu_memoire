FactoryBot.define do
  factory :user do
    email { 'rspec_test@test.com' }
    uid { '123' }
    provider { 'line' }
    name { 'anonymous' }
  end
end
