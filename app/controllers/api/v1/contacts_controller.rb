module Api
	module V1
		class Api::V1::ContactsController < Api::V1::BaseapiController

			# /contacts
			def index
				# send all contacts for this account
				render json: @user.accounts.first.contacts.to_json
			end
			

		end # end Contacts controller
	end # end V1
end # end Api
