FactoryBot.define do
  factory :user do
    email { 'alexandrefontes90@gmail.com' }
    password { 123456 }
    name { 'alex' }
    after(:build) do |user|
      user.images.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'landscape.jpg')), filename: 'landscape.jpg', content_type: 'image/jpg')
    end
  end

  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    password { 123456 }
  end
end