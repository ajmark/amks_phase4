class Event < ActiveRecord::Base
  attr_accessible :active, :name
  
  # Relationships
  has_many :sections
  has_many :registrations, :through => :sections
  
  # Scopes
  scope :alphabetical, order('name')
  scope :active, where('events.active = ?', true)
  scope :inactive, where('events.active = ?', false)
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false" 

  before_destroy :check_if_destroyable
  after_rollback :toggle_active_state

  private 
  def check_if_destroyable
    if self.registrations.empty?
      return true 
    else 
      return false
    end 
  end 

  def toggle_active_state
    self.active = !self.active
    self.save!
  end 
    
end
