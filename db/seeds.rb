User.create!( name: "John the Creator",
							email: "john@foodme.com",
							password: "foobar",
							password_confirmation: "foobar",
							admin: true,
							activated: true,
							activated_at: Time.zone.now )


61.times do |n|
	name = %w(Rickon Arya Bran Sansa Rob Jon Eddard Benjen Brandon Hodor Daenerys Rhaegar Aegon Jaehaerys)
	food = %w(Pizza Mataar Paneer Masala ChowMein Kikalicha Couscous Onion Cilantro Avocado Jalapeno Habanero Garlic)
	adj = %w(baked boiled burnt crisp fried frozen Greasy Juicy Organic Pickled Roasted Salty Smoked Spicy Tangy Zesty)
	User.create!( name: "#{name.sample} #{adj.sample} #{food.sample}",
								email: "example-#{n}@example.com",
								password: "password",
								password_confirmation: "password",
								activated: true,
								activated_at: Time.zone.now)
end