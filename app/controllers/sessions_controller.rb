class SessionsController < ApplicationController
  def new
  	
  end

  def create
  	user = User.authenticate(params[:nickname], params[:password])
  	if user
  		session[:user_id] = user.id
             session[:login_time] = Time.now

             user_login_info = Oj.load(REDIS.get("user_id_#{user.id}"))

            session[:login_num] = user_login_info[:login_num].to_i + 1
            session[:login_dura] = user_login_info[:login_dura]

            user.is_login = true
            user.save

  		redirect_to root_path, notice: "欢迎回来"
  	else
  		flash.now.alert = "无效的用户名或者密码"
  		render "new"
  	end
  end

  def destroy
    now = Time.now
    login_time = session[:login_time].split(" ")
    date = login_time[0].split("-")
    time = login_time[1].split(":")

    pre_time = Time.new(date[0],date[1],date[2],time[0],time[1],time[2])
    login_dura = ((now - pre_time) / 60).round + session[:login_dura]

    uid = session[:user_id]
    login_info = {login_num: session[:login_num], login_dura: login_dura}

    REDIS.set("user_id_#{uid}",Oj.dump(login_info))

    user = User.find(uid)
    user.is_login = false
    user.save

    session[:login_time] = nil
    session[:user_id] = nil
    session[:login_num] = nil
    session[:login_dura] = nil
    flash[:notice] = "下次再见"
    redirect_to root_path
  end
end
