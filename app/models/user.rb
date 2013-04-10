class User < ActiveRecord::Base
  attr_accessible :active, :email, :password_digest, :role, :student_id

  #Relationships
  belongs_to :student

  #Validations
  validates_uniqueness_of :email
  validates_numericality_of :student_id

  #Scopes

  #Methods
  
end
