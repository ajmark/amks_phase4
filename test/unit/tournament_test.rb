require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

	#Relationships
	should have_many(:sections)

	#Validations 
	should validate_presence_of :name
	should validate_presence_of :date
	should validate_presence_of :min_rank
	should validate_numericality_of :min_rank
	should validate_numericality_of :max_rank

	should allow_value(Date.today).for(:date)
	should allow_value(1.day.ago).for(:date)
	should_not allow_value(2).for(:date)
	should_not allow_value('string').for(:date)

	context "Creating Tournament context" do 
	
	setup do 
		create_tournament_context
	end 

	teardown do 
		remove_tournament_context
	end 

	should "have working factories" do 
		assert_equal "Pittsburgh Invitational", @pittsburgh_invitational.name
		assert_equal "Bob Memorial Tournament", @bob_memorial.name
		assert_equal 5, @steel_city_annual.min_rank
	end 

	should "not allow max rank to be smaller than min rank" do 
		@bad = FactoryGirl.build(:tournament, :min_rank => 10, :max_rank => 1)
		deny @bad.valid?
	end 

	#Scopes
	should "have scope to order chronologically" do 
		assert_equal ["Steel City Annual", "Bob Memorial Tournament", "T1", "T2", "Pittsburgh Invitational"], Tournament.chronological.active.map{|a| a.name}
	end 

	should "have scope to order alphabetically" do 
		assert_equal ["Bob Memorial Tournament","Inactive", "Pittsburgh Invitational", "Steel City Annual", "T1", "T2"], Tournament.alphabetical.map{|a| a.name}
	end

	should "have scope to find past tournaments"  do 
		assert_equal ["Bob Memorial Tournament", "Steel City Annual"], Tournament.past.alphabetical.active.map{|a| a.name}
	end  

	should "have scope to find upcoming tournaments" do 
		assert_equal ["Pittsburgh Invitational", "T1", "T2"], Tournament.upcoming.alphabetical.active.map{|a| a.name}
	end 

	should "have scope to find next number of tournaments" do 
		assert_equal ["T1", "T2"], Tournament.next(2).alphabetical.active.map{|a| a.name}
	end 

	should "have scope to find all active tournaments" do 
		assert_equal ["Bob Memorial Tournament", "Pittsburgh Invitational", "Steel City Annual", "T1", "T2"], Tournament.active.alphabetical.map{|a| a.name}
	end

	should "have scope to find all inactive tournaments" do 
		assert_equal ["Inactive"], Tournament.inactive.alphabetical.map{|a| a.name}
	end 

	#Methods
	###TODO####
	#Only deleted if nobody has registered

	end 

end
