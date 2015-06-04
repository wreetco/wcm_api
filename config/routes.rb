Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
	namespace :api do
		namespace :v1 do
			scope '/contacts' do
				post '/' => 'contacts#search' # search for this contact
				post '/new' => 'contacts#new'
				post '/tags/add' => 'contacts#add_tag_to_contact'
			end # end contact scope
			scope '/accounts' do 
				post '/' => 'accounts#index' # account data
				post '/tags' => 'accounts#get_tags' # all tags for that account
				post '/tags/remove' => 'accounts#remove_tag'
			end # end account scope
			scope '/tags' do
				# global tag actions
			end # end tag scope
			#scope '/user' do
			#	post '/auth' => 'users#auth'
			#end # end user ns
		end # end v1 namespace
	end # end API namespace


	
end # end routes