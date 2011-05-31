class Setting < ActiveRecord::Base
  belongs_to :setting_type
  belongs_to :tuning
  belongs_to :setup_group
end
