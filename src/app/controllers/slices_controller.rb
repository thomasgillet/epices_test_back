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
