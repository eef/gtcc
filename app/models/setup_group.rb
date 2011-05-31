class SetupGroup < ActiveRecord::Base
  acts_as_nested_set
  has_many :settings
  has_many :setting_types
end
