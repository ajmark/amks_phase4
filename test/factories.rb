FactoryGirl.define do
  factory :student do
    first_name "Ed"
    last_name "Gruberman"
    rank 1
    waiver_signed true
    date_of_birth 9.years.ago.to_date
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active true
  end
  
  factory :event do
    name "Sparring"
    active true
  end
  
  factory :section do
    association :event
    min_age 9
    max_age 10
    min_rank 1
    max_rank 2
    active true
  end
  
  factory :registration do
    association :section
    association :student
    date Date.today
  end
end
