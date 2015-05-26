module Api
	module V1
		class Api::V1::ContactsController < Api::V1::BaseapiController

			def index
				render json: @user.account.contacts
			end
			

		end
	end #end V1
end # end Api
