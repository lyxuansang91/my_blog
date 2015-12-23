class SessionsController < ApplicationController

  def new
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user.authenticate(params[:session][:password])
      #byebug
      sign_in @user
      flash[:sucess] = "Sign in successfully!"
      redirect_to root_url
    else
      flash[:danger] = "Error!. Please sign in again!"
      render 'new'
    end
  end
end
