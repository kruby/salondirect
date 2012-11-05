class AddDefaultUser < ActiveRecord::Migration
  def self.up
    if !User.find_by_name('thomas')
      User.create(:name => 'thomas', :email => 'ts@kruby.dk',
      :password => 'kf1737', :password_confirmation => 'kf1737', :category => 'Admin', :blogname => 'TKS')
    end
  end

  def self.down
  end
end