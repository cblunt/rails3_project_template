# spec/factories.rb
Factory.define :user do |u|
  u.sequence(:username) { |n| "joe#{n}" }
  u.sequence(:email_address) { |n| "joe.user#{n}@example.com" }
  u.password 'secret'
  u.password_confirmation 'secret'
  u.verified_at Time.parse('2010-03-08 00:00:00')
  u.verification_key 'verify-me'
end

