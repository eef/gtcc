class CreateAdminUser < ActiveRecord::Migration
  def self.up
    user = User.new(:username => "admin", :password => "rcorp12345", :password_confirmation => "rcorp12345", :email => "admin@local.com")
    user.add_role("admin")
    user.add_role("owner")
    if user.save
      puts "User created succefully."
    else
      puts user.errors.inspect
      puts "Unable to create user."
    end
  end
  
  def self.down
     if User.where(:username => "admin").destroy
       puts "User removed successfully"
     else
       puts "Unable to remove user"
     end
  end
end
