FactoryBot.define do
  factory :user do
    employee_id { "MyString" }
    integer { "MyString" }
    email { "MyString@MyString.com" }
    password { "MyString" }
  end

  factory :store_flavor do
    store_id { 1 }
    flavor_id { 1 }
  end

  factory :flavor do
    name { "MyString" }
    active { false }
  end

  factory :shift_job do
    shift_id { 1 }
    job_id { 1 }
  end

  factory :job do
    name { "MyString" }
    description { "MyText" }
    active { false }
  end

  factory :shift do
    assignment_id { 1 }
    date { "2019-04-17" }
    start_time { "15:39:02" }
    end_time { "20:39:02" }
    notes { "MyText" }
  end

    
  factory :store do
    name { "CMU" }
    street { "QF street" }
    city { "Doha" }
    state { "PA" }
    zip { "15213" }
    phone { "1234567891" }
    active { true }
  end

  factory :assignment do
    association :employee
    association :store
    start_date {"2012-01-01"}
  #  end_date {"2012-02-01"}
    pay_level {"1"}
  end

  factory :employee do
    first_name {"Alex"}
    last_name {"Heimann"}
    ssn {"123456789"}
    date_of_birth {"1993-01-01"}
    role {"employee"}
    phone {"123-123-1234"}
    active {"true"}
  end
  
end