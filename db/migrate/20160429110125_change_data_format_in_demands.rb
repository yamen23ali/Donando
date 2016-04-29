class ChangeDataFormatInDemands < ActiveRecord::Migration
  def change
    change_column :demands, :data, :text
  end
end
