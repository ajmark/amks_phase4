class Dojo < ActiveRecord::Base
  before_save :find_dojo_coordinates
  attr_accessible :active, :city, :latitude, :longitude, :name, :state, :street, :zip

  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

  #Relationships
  has_many :dojo_students
  has_many :students, :through => :dojo_students

  #Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_format_of :city, :with => /^[A-Za-z.]+(( [A-Za-z]+)+)?$/
  validates_format_of :street, :with => /^([0-9]+ )?[A-Za-z.#]+(( [A-Za-z.]+)+)?$/
  validates_format_of :zip, :with => /^\d{5}(-\d{4})?$/ 
  validates_inclusion_of :state, :in => %w[PA OH WV], :message => "is not an option", :allow_nil => true, :allow_blank => true
  validates_numericality_of :latitude
  validates_numericality_of :longitude


  #Scopes
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :alphabetical, order('name')

  #Methods
  
  private
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
  #6
  
end
