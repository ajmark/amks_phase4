require 'test_helper'

class UserTest < ActiveSupport::TestCase
	#Relationships
	should belong_to(:student)

	#Validations
	should validate_numericality_of(:student_id)
	should validate_presence_of(:email)
	should validate_presence_of(:password)
	should validate_presence_of(:password_confirmation)
	should allow_value('alex@gmail.com')
	should_not allow_value('alex')
	should_not allow_value('@gmail.com')
end
