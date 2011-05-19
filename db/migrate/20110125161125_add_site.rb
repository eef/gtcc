class AddSite < ActiveRecord::Migration
  def self.up
    user = User.first
    site = Site.new(:name => "Site Name", :url => "http://", :user => user)
    if site.save
      puts "Site created successfully."
    else
      puts site.errors.inspect
      puts "Unable to save site."
    end
  end

  def self.down
    site = Site.first
    if site.destroy
      puts "Site removed successfully."
    else
      puts "Unable to remove site."
    end
  end
end
