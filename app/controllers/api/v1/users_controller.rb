module Api
	module V1
		class Api::V1::UsersController < Api::V1::BaseapiController
			skip_before_filter :authenticate_user_from_token!
			
			# POST /user/auth
			def auth
				# authenticate the user
				user_params = params[:user]
				user = User.new
				user.from_json(user_params.to_json)
				
				render json: {:wreet => 'co'}
			end # end auth action
			

		end # end users controller
	end #end V1
end # end Api
