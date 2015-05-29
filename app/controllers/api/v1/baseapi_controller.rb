
class Api::V1::BaseapiController < ApplicationController
  protect_from_forgery with: :null_session
	before_filter :parse_request, :authenticate_user_from_token!
	
	# methods for the other API controllers 
	def sanitize_obj(obj)
		# clean it up so that it doesn't nosqli the fuck out of us
		# gsub(/["';{}\\]+/, "") current nosql injection prevent regex
		obj.each do |v|
			if v.is_a? Array or v.is_a? Hash # if it's iterabe we need to try again
				v = sanitize_obj(v) # send it back
			end
			if v.is_a? String
				v = v.gsub(/["';{}\\]+/, "") 
			end
		end # end object iteration
	end # end sanitize_obj method
	
	
	private
	
		def parse_request
			begin
				@json = JSON.parse(request.body.read)
			rescue 
				@json = {:status => 'parse error, please verify JSON syntax'}
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
	

