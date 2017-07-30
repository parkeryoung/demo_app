FactoryGirl.define do
  factory :rate_plan do
    sequence(:title) { |n| "Rate Plan #{n}" }
  end
end
