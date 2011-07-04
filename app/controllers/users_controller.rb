class UsersController < ApplicationController
  def index
    @users = User.age_appropes(current_user)
  end

  def show
    @user = User.find(params[:id])

    unless @user.age_appropiate?(current_user)
      redirect_to users_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    params[:user][:your_labels_attributes].delete_if {|k, v| v['label_id'] == "0"}
    @user = User.find(params[:id])

    if @user.username
      params[:user].delete(:username)
    end

    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end