class ChangeColumnName < ActiveRecord::Migration
  def change
  	 rename_column :ngos, :lat, :latitude
  	 rename_column :ngos, :lng, :longitude
  end
end
