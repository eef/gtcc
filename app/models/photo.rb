class Photo < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :photo_data, :styles => SiteConfig.image_styles
  validates_attachment_content_type :photo_data, :content_type => SiteConfig.image_types, :message => 'file must be an image'
  
end
