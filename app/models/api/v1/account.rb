module Api
	module V1
		class Account
			include Mongoid::Document
			# fields
			field :account_name, type: String # name of the account or business
			field :created_date, type: DateTime, default: Date.today
			field :email_opts, type: Hash, default: {:email_enabled => false, :available_addresses => []}
		
			
			# relations
			# belongs_to :user
			has_and_belongs_to_many :users
			has_many :contacts, class_name: "Api::V1::Contact"
			# methods

		end
	end #end V1
end # end Api
