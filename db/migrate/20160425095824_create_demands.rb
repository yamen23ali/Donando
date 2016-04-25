class CreateDemands < ActiveRecord::Migration
  def change
    create_table :demands do |t|
      t.integer :ngo_id
      t.string :data

      t.timestamps
    end
  end
end
