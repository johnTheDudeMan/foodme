module ApplicationHelper

	# Returns page title
	def page_title(title = "")
		base_title = "FOODme"
		title.empty? ? base_title : title + " | " + base_title
	end
end
