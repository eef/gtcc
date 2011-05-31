class SettingType < ActiveRecord::Base
  has_many :settings
  belongs_to :setup_group
end
