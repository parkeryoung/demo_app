FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Product #{n}" }
  end
end
