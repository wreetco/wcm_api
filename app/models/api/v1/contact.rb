module Api
	module V1
		class Contact
			include Mongoid::Document
			# fields
			field :first_name, type: String
			field :last_name, type: String
			field :created_date, type: DateTime, default: DateTime.now
			field :email, type: Hash, default: {:email_address => "", :opt_out => 0}
			field :phone_numbers, type: Hash, default: {:home => "", :mobile => "", :business => ""}
			field :source, type: String
			field :address, type: Hash, default: {:street => "", :unit => "", :city => "", :zip => "", :state => "", :country => ""}
			field :employer, type: Hash, default: {:name => "", :title => "", :department => ""}
			field :contact_form_data, type: Hash
			field :tags, type: Hash # list of tags for this contact, bug fix, mobile app, stuff like that
			field :assignments, type: Hash, default: {:assigned => false, :members => []}
			field :social_accounts, type: Hash, default: {:facebook => "", :twitter => ""}
			
			# relations
			belongs_to :account
			has_and_belongs_to_many :tags, inverse_of: nil, class_name: "Api::V1::Tag"
			# methods

		end
	end #end V1
end # end Api
