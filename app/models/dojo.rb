class Dojo < ActiveRecord::Base
  attr_accessible :active, :city, :latitude, :longitude, :name, :state, :street, :zip

  #Relationships
  has_many :dojo_students
  has_many :students, :through => :dojo_students

  #Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  #Scopes
  scope :active, where('dojos.active = ?', true)
  scope :inactive, where('dojos.active = ?', false)
  scope :alphabetical, order('dojo.name')

  #Methods

  ####TODO####
  #4,6
  
end
