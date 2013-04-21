class Tournament < ActiveRecord::Base
  attr_accessible :active, :date, :max_rank, :min_rank, :name

  #Relationships
  has_many :sections
  has_many :registrations, :through => :sections

  #Validations
  validates_presence_of :name, :date, :min_rank
  validates_numericality_of :min_rank, :only_integer => true, :greater_than => 0
  validates_numericality_of :max_rank, :only_integer => true, :greater_than_or_equal_to => :min_rank, :allow_blank => true
  validates_date :date

  #Scopes
  scope :chronological, order('date')
  scope :alphabetical, order('name')
  scope :past, where('date < ?', Time.now)
  scope :upcoming, where('date > ?', Time.now)
  scope :next, lambda { |i| where('date > ?', Time.now).order('date').limit(i) }
  scope :active, where('tournaments.active = ?', true)
  scope :inactive, where('tournaments.active = ?', false)

  before_destroy :check_if_destroyable
  after_rollback :toggle_active_state

  def toggle_active_state
    self.active = !self.active
    self.save!
  end 

  private
  def check_if_destroyable
    if self.registrations.empty?
      return true 
    else 
      return false
    end 
  end 

end
