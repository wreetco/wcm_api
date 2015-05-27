module Api
	module V1
		class Tag
			include Mongoid::Document
			# fields
			field :tag, type: String
			field :created_date, type: DateTime, default: DateTime.now
			
			# relations
			
			
			# methods

		end
	end #end V1
end # end Api
