require 'test_helper'

class DojoTest < ActiveSupport::TestCase

	#Relationships
	should have_many(:dojo_students)
	should have_many(:students).through(:dojo_students)

	#Validations
	should validate_presence_of(:name)

	#City validations
	should allow_value("Pittsburgh").for(:city)
	should allow_value("San Francisco").for(:city)
	should allow_value("The Coolest City Ever").for(:city)
	should allow_value("St. Pierre").for(:city)
	should_not allow_value(10).for(:city)
	should_not allow_value("@city").for(:city)
	should_not allow_value("Mt/Fuji").for(:city)

	#Street Validations
	should allow_value("30 Lydia Ct.").for(:street)
	should allow_value("St. James Place").for(:street)
	should allow_value("Street").for(:street)
	should_not allow_value("5").for(:street)
	should_not allow_value("/street").for(:street)

	#Zip Validations
	should allow_value("94010").for(:zip)
	should allow_value("94010-0000").for(:zip)
	should_not allow_value("123").for(:zip)
	should_not allow_value("Hello").for(:zip)
	should_not allow_value("123456").for(:zip)

	#State Validations
 	should allow_value("PA").for(:state)
 	should allow_value("WV").for(:state)
 	should allow_value("OH").for(:state)
 	should_not allow_value("bad").for(:state)
 	should_not allow_value(10).for(:state)
 	should_not allow_value("CA").for(:state)
	
	context "Creating Dojo context" do 
		setup do 
			create_dojo_context
		end 

		teardown do 
			remove_dojo_context
		end 

		should "have working factories" do 
			assert_equal "CMU Dojo", @cmu.name
			assert_equal "UPitt Dojo", @pitt.name
			assert_equal "Average Joe's Dojo", @joes.name
		end 

		should "not allow dojos with duplicate names" do 
			@bad = FactoryGirl.build(:dojo, :name => "CMU Dojo")
			deny @bad.valid?
		end 

    	should "have method to identify geocoordinates" do 
    	  assert_in_delta(40.44417, @cmu.latitude, 0.00001)
    	  assert_in_delta(-79.94336, @cmu.longitude, 0.00001)
    	end 

		#Scopes
		should "have scope to alphabetize dojos" do 
			assert_equal ["Average Joe's Dojo", "CMU Dojo", "UPitt Dojo"], Dojo.alphabetical.map{|a| a.name}
		end 

		should "have scope to get all active dojos" do 
			assert_equal ["CMU Dojo", "UPitt Dojo"], Dojo.active.alphabetical.map{|a| a.name}
		end 

		should "have scope to get all inactive dojos" do 
			assert_equal ["Average Joe's Dojo"], Dojo.inactive.alphabetical.map{|a| a.name}
		end 

	end 
end
