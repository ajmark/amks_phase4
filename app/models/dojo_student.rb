class DojoStudent < ActiveRecord::Base
  before_create :end_previous_assignment
  attr_accessible :dojo_id, :end_date, :start_date, :student_id

  #Relationships
  belongs_to :dojo
  belongs_to :student

  #Validations
  validates_presence_of :dojo_id, :student_id, :start_date
  validates_numericality_of :dojo_id, :student_id
  validates_date :start_date, :on_or_before => Date.today
  validates_date :end_date, :after => :start_date, allow_blank: true 

  #Scopes
  scope :current, where('end_date is null')
  scope :by_student, joins(:student).order('last_name, first_name')
  scope :by_dojo, joins(:dojo).order('name')

  #Methods
  def end_previous_assignment 
    assignments = self.student.dojo_students.all
    previous = assignments.select{ |ds| ds.end_date.nil? }.first
    if !assignments.empty? and !previous.nil? 
      previous.end_date = self.start_date
      previous.save! 
    end 
  end 
  
end
