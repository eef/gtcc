class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  easy_roles :roles
  has_one :site
  has_many :owned_cars
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  
  protected
    def password_required?
      !persisted? || password.present? || password_confirmation.present?
    end
end
