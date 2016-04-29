class AddUrlToNgos < ActiveRecord::Migration
  def change
    add_column :ngos, :url, :string
  end
end
