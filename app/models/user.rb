class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  easy_roles :roles
  has_one :site
  has_many :owned_cars
  has_many :tunings
  has_many :results
  has_many :standings
  has_many :races, :foreign_key => "organiser_id"
  has_many :leagues, :foreign_key => "organiser_id"
  has_many :league_entries
  has_many :league_cars
  has_and_belongs_to_many :races
  validates_presence_of :psn_name
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :timezone, :psn_name, :first_name, :last_name
  
  def my_races
    self.races.where(:league_id => nil)
  end
  
  def my_leagues
    
  end
  
  protected
    def password_required?
      !persisted? || password.present? || password_confirmation.present?
    end
end
