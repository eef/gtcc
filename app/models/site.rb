class Site < ActiveRecord::Base
  validates_presence_of :name, :url
  belongs_to :user
  has_many :forums
end
