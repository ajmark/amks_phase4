require 'test_helper'

class UserTest < ActiveSupport::TestCase
	#Relationships
	should belong_to(:student)

	#Validations
	should validate_numericality_of(:student_id)
	should validate_presence_of(:email)
	should validate_presence_of(:password_digest)

	#Email validations
	should allow_value('alex@gmail.com').for(:email)
	should_not allow_value('alex').for(:email)
	should_not allow_value('@gmail.com').for(:email)
	should_not allow_value(1).for(:email)

	#Student_id validation
	# should allow_value(2).for(:student_id)
	# should_not allow_value("string").for(:student_id)

	#password
	should allow_value("password").for(:password)
	should_not allow_value("hi").for(:password)

	#Active validations
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)

	context "Creating user context" do 
		setup do 
			create_student_context
			create_user_context
		end 

		teardown do 
			remove_student_context
			remove_user_context
		end 

    	should "not allow users for inactive students" do
    	  @bad_user = FactoryGirl.build(:user, :student => @jason)
    	  deny @bad_user.valid?
    	end
	
	end 
end
