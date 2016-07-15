module UsersHelper

	def user_avatar(user)
		if user.avatar?
			user.avatar_url
		else
			"sample_avatars/avatar_#{rand(1..20)}.png"
		end
	end
end
