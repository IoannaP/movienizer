class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable , :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true, :uniqueness => {:case_sensitive => false}

  has_many :lists
  has_many :reviews

  has_many :invitees, class_name: "User", foreign_key: :invited_by_id
  belongs_to :inviter, class_name: "User", foreign_key: :invited_by_id
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

   def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end 
  end

  def self.find_for_facebook_oauth(auth) 
    where(auth.slice(:provider, :uid)).first_or_create do |user| 
      user.provider = auth.provider 
      user.uid = auth.uid 
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0,20] 
      user.username = auth.info.name.split[0]
      user.skip_confirmation! 
      user.save! 
    end 
  end
end

