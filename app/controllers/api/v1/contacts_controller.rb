module Api
	module V1
		class Api::V1::ContactsController < Api::V1::BaseapiController

			# /contacts
			def index
				# we need to check for params
				if params[:search_params][:tag]
					tag = params[:search_params][:tag].match(/[A-Za-z0-9\s]+/)[0];
					# lets search this account's contact's for this tag
					# in theory we could 'un-nill' the inverse relation on the tag 
					# model to be able to do tag_obj.contacts but that would search the
					# whole db and all account's with an expensive many-to-many
					contacts = [];
					@user.accounts.first.contacts.each do |c| # each contact
						c.tags.each do |t| # each contact tag
							if t.tag == tag
								# add this contact to the list to be returned
								contacts << c
							end 
						end # end tag iteration
					end # end contacts iteration
					# return our list of contacts
					render json: contacts.to_json
					return
				end # end tag search
				
				
				# if we make it here then send all contacts for this account, no search params
				render json: @user.accounts.first.contacts.to_json
			end
			

		end # end Contacts controller
	end # end V1
end # end Api
