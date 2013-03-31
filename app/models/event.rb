class Event < ActiveRecord::Base
  attr_accessible :active, :name
  
  # Relationships
  has_many :sections
  
  # Scopes
  scope :alphabetical, order('name')
  scope :active, where('events.active = ?', true)
  scope :inactive, where('events.active = ?', false)
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false" 
    
end
