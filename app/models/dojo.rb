class Dojo < ActiveRecord::Base
  before_save :find_dojo_coordinates
  attr_accessible :active, :city, :latitude, :longitude, :name, :state, :street, :zip

  #Relationships
  has_many :dojo_students
  has_many :students, :through => :dojo_students

  #Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  #Scopes
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :alphabetical, order('name')

  #Methods

  def find_dojo_coordinates
  coord = Geocoder.coordinates("#{street}, #{city}, #{state}, #{zip}")
  if coord
    self.latitude = coord[0]
    self.longitude = coord[1]
  else 
    errors.add(:base, "Error with geocoding")
  end
  coord
end

  ####TODO####
  #4,6
  
end
