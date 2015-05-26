
class Api::V1::BaseapiController < ApplicationController
  protect_from_forgery with: :null_session
	before_filter :parse_request, :authenticate_user_from_token!
	
	private
	
		def parse_request
			begin
				@json = JSON.parse(request.body.read)
			rescue 
				@json = {:wreet => 'co'}
			end
		end
	
		def authenticate_user_from_token!
			if !@json['api_token']
				render json: {:status => 'unauthorized'}, status: :unauthorized
			else
				@user = nil
				User.all.each do |u|
					if Devise.secure_compare(u.api_token, @json['api_token'])
						@user = u
				end
				# if we get out without a user then the token is no good
				if @user == nil
					render json: {:status => 'unauthorized'}, status: :unauthorized
				end;
			end
		end # end auth from token
			
	end # end private
	
end
	

