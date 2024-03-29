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
    association :tournament
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

  factory :tournament do
    name "Bob Memorial Tournament"
    min_rank 1
    date Date.today
    active true 
  end

  factory :dojo do 
    name "CMU Dojo"
    city "Pittsburgh"
    latitude 1.0 
    longitude 1.0 
    state "PA"
    street "5000 Forbes Ave"
    zip "15289"
    active true
  end 

  factory :dojo_student do
    association :dojo
    association :student
    start_date 1.year.ago
  end 

  factory :user do 
    association :student 
    email 'student@gmail.com'
    password "secret"
    password_confirmation "secret"
    role "member"
    active true
  end 

end
