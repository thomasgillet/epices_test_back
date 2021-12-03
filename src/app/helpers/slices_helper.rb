require 'csv'

module SlicesHelper
	
	# Timestamp format in CSV files
	DATETIME_FORMAT = "%d/%m/%y %H:%M"
	
	# Extract slices from a CSV file and upsert them into the DB
	# Returns:
	# - the minimum DateTime in the file
	# - the maximum DateTime in the file
	def import_from_csv(file)

		# Timestamp converter
		# TODO Uses DateTime rather than Time to output local times and avoid timezone issues in DB.
		#      Maybe not the best idea, but make extracting date easier. Investigate a better solution.
		to_datetime = proc { |str| DateTime.strptime str, DATETIME_FORMAT rescue str }
		
		# Initialization
		now = DateTime.now
		slices = Array.new
		min = nil
		max = nil
	
		# Parsing
		CSV.foreach file.path, headers: true, converters: to_datetime do |row|
			
			# Create slice hash
			slice = {
				source: row["identifier"],
				timestamp: row["datetime"],
				energy: row["energy"],
				created_at: now,
				updated_at: now
			}
			slices << slice
			
			# Update boundaries
			ts = slice[:timestamp]
			min = ts if min == nil || min > ts
			max = ts if max == nil || max < ts
			
		end
		
		# Upserting
		# TODO Doesn't work if index not specified despite doc stating all unique indexes are used. Investigate.
		Slice.upsert_all slices, unique_by: [ :source, :timestamp ]
		
		# Done
		return min, max;
		
	end
	
	# Update cube table with consolidated data for all days between given min and max datetimes.
	def update_cube(min, max)
		
		# Boudaries: encompass all days which have changed
		min = min.beginning_of_day
		max = max.end_of_day
		
		# Query
		# TODO Easy in SQL, but maybe non-standard. Better to use rails API if possible. Investigate.
		execute_sql(
			%{
				INSERT INTO slice_cubes(day, energy, created_at, updated_at)
					SELECT date(timestamp) day, SUM(energy), datetime('now'), datetime('now')
					FROM slices
					WHERE timestamp BETWEEN ? and ?
					GROUP BY day
				ON CONFLICT(day) DO UPDATE
				SET energy=EXCLUDED.energy, updated_at=EXCLUDED.updated_at
			},
			min,
			max
		)

	end
	
	private

	# Execute custom SQL with sanitization
	def execute_sql(*sql_query)
		ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array(sql_query))
	end

end
