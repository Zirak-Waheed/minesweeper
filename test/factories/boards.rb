FactoryBot.define do
  factory :board do
    sequence(:name) { |n| "Board #{n}" }
    sequence(:email) { |n| "board#{n}@example.com" }
    length { 5 }
    width { 5 }
    mines { 10 }
  end
end

