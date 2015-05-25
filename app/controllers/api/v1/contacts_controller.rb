module Api
	module V1
		class Api::V1::ContactsController < ApplicationController

			def index
				render json: @user
			end
			

		end
	end #end v1
end # end API
