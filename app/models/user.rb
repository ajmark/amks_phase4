class User < ActiveRecord::Base
  attr_accessible :active, :email, :password_digest, :role, :student_id

  #Relationships
  belongs_to :student

  #Validations
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_numericality_of :student_id
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format", :allow_blank => true
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, :message => "does not match"

  #Scopes

  #Methods
  
end
