class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable , :validatable

  validates :username, :uniqueness => {:case_sensitive => false}

  has_many :lists
  has_many :reviews

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'

  attr_accessor :login
  
  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end  

end

