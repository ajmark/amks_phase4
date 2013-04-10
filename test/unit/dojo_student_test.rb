require 'test_helper'

class DojoStudentTest < ActiveSupport::TestCase
	
	#Relationships
	should belong_to(:dojo)
	should belong_to(:student)

	#Validations
	should validate_presence_of(:dojo_id)
	should validate_presence_of(:student_id)
	should validate_presence_of(:start_date)
	should validate_numericality_of(:dojo_id)
	should validate_numericality_of(:student_id)
	#Date Validations
	should allow_value(1.year.ago).for(:start_date)
	should_not allow_value(2).for(:start_date)
	should_not allow_value("Hellooo").for(:start_date)

	should allow_value(nil).for(:end_date)
	should_not allow_value(2).for(:end_date)
	should_not allow_value("Haiii").for(:end_date)

	context "Creating dojo student context" do 
		setup do 
			create_student_context
			create_dojo_context
			create_dojo_student_context
		end 

		teardown do 
			remove_student_context
			remove_dojo_context
			remove_dojo_student_context
		end 

	#Scopes

		should "have scope to gather active records only" do 
			assert_equal [""], DojoStudent.current.map{|a| a.student.name}
		end 

		should "have scope to order records by student last and first names" do 
			assert_equal ["Gruberman, Ed", "Hanson, Jen", "Hanson, Jen", "Hoover, Jason"], DojoStudent.by_student.map{|a| a.student.name}
		end 

		should "have scope to order records by dojo name" do 
			assert_equal ["CMU Dojo", "CMU Dojo", "UPitt Dojo", "UPitt Dojo"], DojoStudent.by_dojo.map{|a| a.dojo.name}
		end 

	#Methods
		#end previous assignment
	end 
end
