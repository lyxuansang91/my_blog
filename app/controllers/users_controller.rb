class UsersController < ApplicationController

  #before_action :signed_in_user

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:sucess] = "Welcome to my blog!"
      redirect_back_or @user
    else
      flash[:danger] = "Sign up errors!"
      render 'new'
    end
  end

  private
    def user_params
      params.required(:user).permit(:name,
       :email,
       :password,
       :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
         store_location
         redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
end
