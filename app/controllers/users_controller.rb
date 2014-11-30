class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
          session[:user_id] = @user.id
          session[:login_time] = Time.now
          session[:login_num] = 1
          session[:login_dura] = 0

          hash = {login_num: 1,login_dura: 0}
          REDIS.set("user_id_#{current_user.id}",Oj.dump(hash))

          flash[:notice] = "注册成功！"
  	    redirect_to root_path
  	else	
  		render "new"
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:password, :nickname, :password_confirmation)
  end
end
