class SessionsController < ApplicationController
  def new
  	
  end

  def create
  	user = User.authenticate(params[:nickname], params[:password])
  	if user
  		cookies[:user_id] = user.id
              if cookies[:user_id]
                if cookies[:count]
                    cookies[:count] = 1
                else  
                    cookies[:count] = cookies[:count].to_i + 1
                end

              else
                cookies[:count] = 1
                cookies[:time] = Time.now
              end
  		redirect_to root_path, notice: "欢迎回来"
  	else
            cookies[:user_id] = nil
  		flash.now.alert = "无效的用户名或者密码"
  		render "new"
  	end
  end

  def destroy
    cookies[:user_id] = nil
    cookies[:time] = nil
    cookies[:count] = nil
    cookies.delete(:user_id)
    cookies.delete(:time)
    cookies.delete(:count)
    flash[:notice] = "下次再见"
    redirect_to root_path
  end
end
