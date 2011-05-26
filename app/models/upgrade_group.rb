class UpgradeGroup < ActiveRecord::Base
  acts_as_nested_set
  has_many :upgrades, :foreign_key => :parent_id
end
