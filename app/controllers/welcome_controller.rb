class WelcomeController < ApplicationController
	def index
		@login_count = User.where(is_login: true).count

		now = Time.now

		if current_user
			login_time = session[:login_time].split(" ")

			# puts login_time.inspect
			date = login_time[0].split("-")
			time = login_time[1].split(":")

			# puts "ddddsssseee"
			# puts session[:login_dura]

			pre_time = Time.new(date[0],date[1],date[2],time[0],time[1],time[2])
			# puts pre_time
			@time = ((now - pre_time) / 60).round + session[:login_dura]
			@count = session[:login_num]
		else
			if session[:login_time]
				login_time= session[:login_time].split(" ")
				date = login_time[0].split("-")
				time = login_time[1].split(":")

				pre_time = Time.new(date[0],date[1],date[2],time[0],time[1],time[2])
				# puts pre_time

				@time = ((now - pre_time) / 60).round
			else
				session[:login_time] = now
				@time = 0
			end

		end
	end

	def get_login_num
		login_count = User.where(is_login: true).count
		#not_login_count 不知道怎么区分未登录用户，所以没有做
		not_login_count = 0

		render json: {login_count: login_count, not_login_count: not_login_count}
	end

end
