class CreateSliceCubes < ActiveRecord::Migration[6.1]
	def change
	
		create_table :slice_cubes do |t|
			t.date :day
			t.integer :energy
			t.timestamps
		end
	
		add_index :slice_cubes, :day, unique: true
		
	end
end
