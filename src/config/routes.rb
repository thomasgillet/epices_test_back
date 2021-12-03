Rails.application.routes.draw do
	
	root "slices#index"
	
	get  "slices/index"
	get  "slices/new_import"
	post "slices/create_import"

end
