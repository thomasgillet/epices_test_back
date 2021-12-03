# TODOs
#
# No check for CSV content.
# Should we prevent CSV with more than one day of data? Or not all 24 hours of data?
#
# Kept `created_at` and `updated_at` fields from model generator.
# Not sure its really usefull, especially with upsert also updating `created_at` (but seems to be an "update_only" option coming soon)
#
# UPSERT used to import data to ease development.
# Probably better to at least warn the user before overwriting data.
#
# Timezones not handled. See if it is necessary.
# /!\ If it is, beware of DateTime to Date transformation!
#
# No relation between slices and its cube. Does data really belong to its cube? Meeeh...
# OneToMany cube -> slice relation may ease data retrieval with rails ORM stuffs, and deletion with cascading foreign key.
# But not so easy if other grouping levels are added (week, month, year...)
#

class SlicesController < ApplicationController
	
	# Helper for CSV and database processing
	include SlicesHelper

	# Show import form
	def new_import
	end

	# Do import
	def create_import
		
		begin
			
			# Import
			min, max = import_from_csv(params[:file])
			
			#Cube
			update_cube(min, max)
			
			# Done
			redirect_to action: :index, day: min.beginning_of_day.to_date

		rescue => e
		 	@error = e.message
			render :new_import
		end
		
	end
	
	# Show data
	def index
		
		# Param
		day = params[:day].to_date rescue nil
		
		# If param given, set corresponding data
		if day
			@cube = SliceCube.find_by(day: day)
			@slices = Slice.where(timestamp: day.beginning_of_day..day.end_of_day)
		end
		
		# Set param range
		# TODO Find a way to use only one request (easy in raw SQL but is there a rails helper?)
		@day_range = [ SliceCube.minimum(:day), SliceCube.maximum(:day) ]
		
		# Set param value
		@day = day ? day : @day_range.first
		
	end
	
end
