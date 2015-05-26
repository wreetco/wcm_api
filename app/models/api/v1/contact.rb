module Api
	module V1
		class Contact
			include Mongoid::Document
			# fields
			field :first_name, type: String
			field :last_name, type: String
			field :email, type: Hash, default: {:email_address => "", :opt_out => 0}
			field :phone_numbers, type: Hash, default: {:home => "", :mobile => ""}
			field :source, type: String
			field :address, type: Hash, default: {:street => "", :unit => "", :city => "", :zip => "", :state => "", :country => ""}
			field :work_name, type: String # their office name
			field :work_title, type: String # their title
			field :contact_form_data, type: Hash
			
			
			# relations
			belongs_to :account
			# methods

		end
	end #end V1
end # end Api
