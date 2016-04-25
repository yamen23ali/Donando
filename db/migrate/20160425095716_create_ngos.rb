class CreateNgos < ActiveRecord::Migration
  def change
    create_table :ngos do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
