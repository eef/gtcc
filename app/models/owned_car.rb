class OwnedCar < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  
  def tunings
    Tuning.where(:car_id => self.car_id).where(:user_id => self.user_id).all
  end
  
end
