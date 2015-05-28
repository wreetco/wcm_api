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
			
			# /accounts/tags/remove
			def remove_tag
				# clean the tag id
				# since we are on account, we are removing this tag from _all_ contacts in account
				tag_id = params[:tag_id].match(/[A-Fa-z0-9]+/)[0]
				@user.accounts.first.contacts.each do |c|
					c.tags.each do |t|
						if t.id.to_s == tag_id
							c.tags.delete(t);
							# we should save
							c.save
						end
					end
				end
				# made it out, we coo
				render json: {:status => 'tag removed from account'}
			end # end remove_tag method
			

		end # end accounts controller
	end #end V1
end # end Api
