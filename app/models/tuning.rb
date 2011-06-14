class Tuning < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  has_and_belongs_to_many :upgrades
  has_many :settings, :dependent => :destroy
  
  after_save :create_settings
  
  def create_settings
    setting_types = SettingType.all
    setting_types.each do |st|
      setting = Setting.new
      setting.tuning = self
      setting.setup_group = st.setup_group
      setting.setting_type = st
      setting.save
    end
  end
  
end
