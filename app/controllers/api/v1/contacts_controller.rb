module Api
	module V1
		class Api::V1::ContactsController < Api::V1::BaseapiController

			# /contacts
			def search
				# we need to check for params
				# do the tag search
				if params[:search_params][:tag]
					tag = params[:search_params][:tag].match(/[A-Za-z0-9\s]+/)[0]
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
				
				# do assignment handling
				if params[:search_params][:assigned]
					# clean it
					assigned = params[:search_params][:assigned].match(/[A-Za-z0-9\s]+/)[0]
					contacts = []
					if assigned == "unassigned"
						# get only unassigned contacts
						@user.accounts.first.contacts.each do |c| # each contact
							if c.assignments[:assigned] == false
								# unassigned contact
								contacts << c
							end
						end # end iterate contacts
					elsif assigned == "all"
						contacts = @user.accounts.first.contacts
					else
						# otherwise we know to search by a username(email address)
						if assigned == "mine" # we know to use our email
							assigned = @user.email
						end
						# now we use it to get back all account contacts that have this member
						@user.accounts.first.contacts.each do |c| # each contact
							c.assignments[:members].each do |m| # each member
								if m == assigned
									contacts << c
								end
							end # end members iteration 
						end # end contact iteration
							
					end # end assigned/unassigned if/else
					render json: contacts.to_json
					return
				end # end assign handling
				
				# if we make it here then send all contacts for this account, no search params
				render json: @user.accounts.first.contacts.to_json
			end # end index/search method
			
			# /contacts/new
			def new
				# we are going to make a new contact yall
				# comes in like post
				# {'api_token': ..., 'contact': {}}
				contact_params = params[:contact] # be sure to clean all the values
				# clean them up
				contact_params = sanitize_obj(contact_params);
				# lets allow rails to build this for us automagically
				c = Contact.new
				c.from_json(contact_params.to_json) # generate from our cleaned params
				# should be it for that, as long as the keys mactch rails should set it
				
				# now we can save the contact
				#c.save
				# now let's this new contact to the client
				render json: {:status => "success", :contact => c}
			end # end new contact
			
			
			# /contacts/tags/add
			def add_tag_to_contact
				
			end # end add_tag_to_contact method
			
			# /contacts/tags/remove
			def remove_tag_from_contact
				# unlike the remove method in account, this only removes the tag from one contact
				
			end # end remove_tag_from_contact method
			
			
			

		end # end Contacts controller
	end # end V1
end # end Api










