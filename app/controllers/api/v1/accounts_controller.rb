module Api
	module V1
		class Api::V1::AccountsController < Api::V1::BaseapiController

			# /accounts
			def index
				# send back account data
				render json: @user.accounts.first.to_json
			end
			
			# /accounts/tags
			def get_tags
				# get all tags from contacts in this account
				contacts = @user.accounts.first.contacts
				tags = [];
				contacts.each do |c| # each contact
					c.tags.each do |t| # each contact tag
						tags << t # jam it into the list
					end # end tags
				end # end contacts
				render json: tags.to_json
			end # end get_tags method
			

		end # end accounts controller
	end #end V1
end # end Api
