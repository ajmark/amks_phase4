require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Prof. H's deny method to improve readability of tests
  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end
  
  # Context for events
  def create_event_context
    @sparring = FactoryGirl.create(:event)
    @breaking = FactoryGirl.create(:event, :name => "Breaking")
    @weapons = FactoryGirl.create(:event, :name => "Weapons", :active => false)
  end
  
  def remove_event_context
    @sparring.destroy
    @breaking.destroy
    @weapons.destroy
  end
  
  # Context for students
  def create_student_context
    @ed = FactoryGirl.create(:student)
    @ted = FactoryGirl.create(:student, :first_name => "Ted", :phone => "412-268-2323")
    @fred = FactoryGirl.create(:student, :first_name => "Fred", :rank => 9)
    @ned = FactoryGirl.create(:student, :first_name => "Ned", :date_of_birth => 13.years.ago.to_date)
    @noah = FactoryGirl.create(:student, :first_name => "Noah", :last_name => "Major", :rank => 9, :date_of_birth => 13.years.ago.to_date)
    @howard = FactoryGirl.create(:student, :first_name => "Howard", :last_name => "Minor", :rank => 8, :date_of_birth => 169.months.ago.to_date)
    @jen = FactoryGirl.create(:student, :first_name => "Jen", :last_name => "Hanson", :rank => 12, :date_of_birth => 167.months.ago.to_date)
    @julie = FactoryGirl.create(:student, :first_name => "Julie", :last_name => "Henderson", :rank => 11, :date_of_birth => 1039.weeks.ago.to_date, :waiver_signed => false)
    @jason = FactoryGirl.create(:student, :first_name => "Jason", :last_name => "Hoover", :rank => 14, :active => false, :date_of_birth => 36.years.ago.to_date)
  end
  
  def remove_student_context
    @ed.destroy
    @ted.destroy
    @fred.destroy
    @ned.destroy
    @noah.destroy
    @jen.destroy
    @howard.destroy
    @julie.destroy
    @jason.destroy
  end
  
  # Context for sections (requires events)
  def create_section_context
    @wy_belt_sparring = FactoryGirl.create(:section, :event => @sparring)
    @wy_belt_breaking = FactoryGirl.create(:section, :event => @breaking)
    @r_belt_breaking = FactoryGirl.create(:section, :event => @breaking, :min_rank => 8, :max_rank => 10, :min_age => 13, :max_age => 15)
    @r_belt_sparring = FactoryGirl.create(:section, :event => @sparring, :min_rank => 8, :max_rank => 10, :min_age => 13, :max_age => 15, :active => false)
    @bl_belt_breaking = FactoryGirl.create(:section, :event => @breaking, :min_rank => 11, :max_rank => nil, :min_age => 18, :max_age => nil)
  end
  
  def remove_section_context
    @wy_belt_sparring.destroy
    @wy_belt_breaking.destroy
    @r_belt_breaking.destroy
    @r_belt_sparring.destroy
    @bl_belt_breaking.destroy
  end
  
  # Context for registrations (requires sections, students)
  def create_registration_context
    @reg_ed_sp = FactoryGirl.create(:registration, :student => @ed, :section => @wy_belt_sparring)
    @reg_ted_sp = FactoryGirl.create(:registration, :student => @ted, :section => @wy_belt_sparring)
    @reg_ted_br = FactoryGirl.create(:registration, :student => @ted, :section => @wy_belt_breaking)
    @reg_hm_br = FactoryGirl.create(:registration, :student => @howard, :section => @r_belt_breaking, :date => 1.day.ago.to_date)
    @reg_nm_br = FactoryGirl.create(:registration, :student => @noah, :section => @r_belt_breaking, :date => 2.days.ago.to_date)
  end
  
  def remove_registration_context
    @reg_ed_sp.destroy
    @reg_ted_sp.destroy
    @reg_ted_br.destroy
    @reg_nm_br.destroy
    @reg_hm_br.destroy
  end
end