require 'test_helper'

class DojoTest < ActiveSupport::TestCase

	#Relationships
	should have_many(:dojo_students)
	should have_many(:students).through(:dojo_students)

	#Validations
	should validate_presence_of(:name)

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

		#Methods

	end 
end
