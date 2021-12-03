class CreateSlices < ActiveRecord::Migration[6.1]
  def change
	
    create_table :slices do |t|
      t.integer :source
      t.datetime :timestamp
      t.integer :energy
      t.timestamps
    end
	
    add_index :slices, [ :source, :timestamp ], unique: true
	
  end
end
