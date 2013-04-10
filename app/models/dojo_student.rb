class DojoStudent < ActiveRecord::Base
  attr_accessible :dojo_id, :end_date, :start_date, :student_id

  #Relationships
  belongs_to :dojo
  belongs_to :student

  #Validations
  validates_presence_of :dojo_id, :student_id, :start_date
  validates_numericality_of :dojo_id, :student_id
  validates_date :start_date
  validates_date :end_date

  #Scopes
  #scope :current, where()
  scope :by_student, joins(:student).order('last_name, first_name')
  scope :by_dojo, joins(:dojo).order('name')

  #Methods
  
end