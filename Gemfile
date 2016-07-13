source 'https://rubygems.org'
ruby "2.3.0"

# Not sure when or if my app will need the commented out gems

gem 'rails', '4.2.6'
gem 'bcrypt'
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
# Removes whitespaces to serve files quicker
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
# Allows you to create an interactive Ruby session in your browser
# Access an IRB console on exception pages or by using <%= console %> in views  
gem 'web-console', group: :development
# Create JSON structures via a Builder-style DSL
# gem 'jbuilder', '~> 2.0'
# RDoc generator to build searchable HTML documentation
# gem 'sdoc', '~> 0.4.0', group: :doc


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'sqlite3'
  # Preloads your application so things like console, rake and tests run faster
	# speeds up development by keeping your application running in the background 
  gem 'spring'
end

group :test do
	# Swaps out Minitest runner to the custom one used by minitest-reporters
  gem 'minitest-reporters'
  # MiniBacktrace allows you to take advantage of the Rails.backtrace_cleaner when using MiniTest
  gem 'mini_backtrace'
	# Automatically run your tests  
  # gem 'guard-minitest'
end

group :production do
  gem 'pg'
  # Runs rails the 12 factor way. Two biggest areas right now are that in production 
  # logs should be directed to stdout and dev/prod parity while delivering assets
  # Enables serving assets in production and setting your logger to standard out
  gem 'rails_12factor'
  gem 'puma'
end