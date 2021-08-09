class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "#{@user.username}, welcome to the AlphaBlog!"
      redirect_to articles_path
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end