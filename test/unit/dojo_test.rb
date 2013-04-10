require 'test_helper'

class DojoTest < ActiveSupport::TestCase

	#Relationships
	should have_many(:dojo_students)
	should have_many(:students).through(:dojo_students)

	#Validations
	should validate_presence_of(:name)

	
end
