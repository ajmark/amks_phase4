class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :active, :email, :password, :password_confirmation, :role, :student_id

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
  validates_length_of :password, :minimum => 4, :message => "must be at least 4 characters long", :allow_blank => true

  #validates :connected_to_active_user, :on => :create 




  
end
