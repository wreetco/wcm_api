class SessionsController < Devise::SessionsController  
	clear_respond_to
	respond_to :json
	skip_before_filter :authenticate_user_from_token!, :verify_authenticity_token
	
	def create
		user = User.find_by(email: params[:user][:email])
		if user.valid_password?(params[:user][:password])
			render json: user
		else
			render json: {:wreet => 'co'}
		end
	end
	
	
end  