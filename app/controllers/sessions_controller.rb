class SessionsController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def create
    auth = request.env["omniauth.auth"]
    if current_user
      provider = Provider.from_auth(auth, ip_address: request.remote_ip)
      if provider
        current_user.merge! provider.user
        current_user.providers << provider
      else
        current_user.providers << Provider.create!(name: auth["provider"], uid: auth['uid'])
      end

    else
      provider = Provider.from_auth(auth, ip_address: request.remote_ip)
      user = provider ? provider.user : User.create_with_omniauth(auth)
      cookies.signed[:auth_token] = {value: user.auth_token, expires: 2.weeks.from_now, secure: Rails.env.production?}
    end

    redirect_to people_path
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :auth_token
    redirect_to root_url, notice: "Signed out. Bye, for now!"
  end
  
  def failure
    redirect_to root_url, notice: params[:message]
  end
end
