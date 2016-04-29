class AddOthersToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :others, :string
  end
end
