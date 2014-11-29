class WelcomeController < ApplicationController
	def index
		if current_user
			if cookies[:count]
				cookies[:count] = cookies[:count].to_i + 1
			else
				cookies[:count] = 1
			end
		end

		now = Time.now

		if cookies[:time]
			date,time = cookies[:time].split(" ")
			date = date.split("-")
			time = time.split(":")

			pre_time = Time.new(date[0],date[1],date[2],time[0],time[1],time[2])
			@time = ((now - pre_time) / 60).round
		else
			cookies[:time] = now
			@time = 0
		end
		@count = cookies[:count]

		@users_num = User.count
	end

end
