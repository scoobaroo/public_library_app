class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]
  def index
    @users = User.all
    render :index
  end
  def new
     # we need to make
     # a new user
     # to pass to the
     # form later
     @user = User.new
     render :new
  end
  def create
    @user = User.create(user_params)
    login(@user) # <-- login the user
    redirect_to @user # <-- go to show
  end
  def edit
    @user = User.find_by_id(params[:id])
    if current_user==@user
      render :edit
    else
      redirect_to users_path
    end
  end
  def update
    @user = User.find_by_id(params[:id])
    if @user==current_user
      @user.update(user_params)
      flash[:notice] = "Successfully Edited!"
      redirect_to @user
    else
      redirect_to users_path
    end
  end
  def show
    @user = User.find_by_id(params[:id])
    @libraries = @user.libraries
    time = @user.created_at
    @month=time.strftime("Created on %m/%d/%Y")
    @daytime=time.strftime("%I:%M%p")
    if @user==current_user
      render :show
    else
      redirect_to users_path
    end
  end
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
