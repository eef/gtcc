class Upgrade < ActiveRecord::Base
  belongs_to :upgrade_group
  has_and_belongs_to_many :tunings
end
