# spec/factories.rb
Factory.define :user do |u|
  u.email_address 'joe.user@example.com'
  u.password 'secret'
end

