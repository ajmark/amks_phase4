# Context for events
def create_events_context
  @sparring = FactoryGirl.create(:event)
  @breaking = FactoryGirl.create(:event, :name => "Breaking")
  @forms = FactoryGirl.create(:event, :name => "Forms")
  @weapons = FactoryGirl.create(:event, :name => "Weapons", :active => false)
end

# Context for students
def create_white_yellow_belt_context
  # ASSUMES THAT EVENT CONTEXT WAS CREATED FIRST
  
  # first, create sections for white and yellow belts
  @wy_belt_sparring = FactoryGirl.create(:section, :event => @sparring)
  @wy_belt_breaking = FactoryGirl.create(:section, :event => @breaking)
  @wy_belt_forms = FactoryGirl.create(:section, :event => @forms)
  
  # second, create some students who could register 
  @ed = FactoryGirl.create(:student)
  @ted = FactoryGirl.create(:student, :first_name => "Ted", :phone => "412-268-2323", :date_of_birth => Date.new(2003,04,01))
  @ned = FactoryGirl.create(:student, :first_name => "Ned", :date_of_birth => 13.years.ago.to_date)
  @fred = FactoryGirl.create(:student, :first_name => "Fred")
  
  # finally, create some registrations
  @reg_ed_sp = FactoryGirl.create(:registration, :student => @ed, :section => @wy_belt_sparring)
  @reg_ted_sp = FactoryGirl.create(:registration, :student => @ted, :section => @wy_belt_sparring)
  @reg_ted_br = FactoryGirl.create(:registration, :student => @ted, :section => @wy_belt_breaking)
end

def create_red_belt_context
  # ASSUMES THAT EVENT CONTEXT WAS CREATED FIRST
  
  # first, create sections for red belts (1st-3rd gups)
  @r_belt_breaking = FactoryGirl.create(:section, :event => @breaking, :min_rank => 8, :max_rank => 10, :min_age => 13, :max_age => 15)
  # @r_belt_sparring = FactoryGirl.create(:section, :event => @sparring, :min_rank => 8, :max_rank => 10, :min_age => 13, :max_age => 15, :active => false)
  @r_belt_forms = FactoryGirl.create(:section, :event => @forms, :min_rank => 8, :max_rank => 10, :min_age => 13, :max_age => 15, :active => false)
  
  # second, create some red belt students
  @fred = FactoryGirl.create(:student, :first_name => "Fred", :rank => 9)
  @noah = FactoryGirl.create(:student, :first_name => "Noah", :last_name => "Major", :rank => 9, :date_of_birth => 13.years.ago.to_date)
  @howard = FactoryGirl.create(:student, :first_name => "Howard", :last_name => "Minor", :rank => 8, :date_of_birth => 169.months.ago.to_date)
  
  # finally, create some registrations
  @reg_hm_br = FactoryGirl.create(:registration, :student => @howard, :section => @r_belt_breaking, :date => 1.day.ago.to_date)
  @reg_nm_br = FactoryGirl.create(:registration, :student => @noah, :section => @r_belt_breaking, :date => 2.days.ago.to_date)
end

def create_black_belt_context
  # sections
  @bl_belt_breaking = FactoryGirl.create(:section, :event => @breaking, :min_rank => 11, :max_rank => nil, :min_age => 18, :max_age => nil)
  # students
  @jen = FactoryGirl.create(:student, :first_name => "Jen", :last_name => "Hanson", :rank => 12, :date_of_birth => 167.months.ago.to_date)
  @julie = FactoryGirl.create(:student, :first_name => "Julie", :last_name => "Henderson", :rank => 11, :date_of_birth => 1039.weeks.ago.to_date, :waiver_signed => false)
  @jason = FactoryGirl.create(:student, :first_name => "Jason", :last_name => "Hoover", :rank => 14, :active => false, :date_of_birth => 36.years.ago.to_date)
end

Given /^an initial setup$/ do
  create_events_context
  create_white_yellow_belt_context
end

Given /^red and white belt students$/ do
  create_events_context
  create_white_yellow_belt_context
  create_red_belt_context
end