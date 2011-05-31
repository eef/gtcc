class Tuning < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  has_and_belongs_to_many :upgrades
  has_many :settings
  
  def create_settings
    setting_types = SettingType.all
    setting_types.each do |st|
      setting = Setting.new
      setting.user = self.user
      
    end
  end
  
end
