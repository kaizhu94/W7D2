class SessionsController < ApplicationController

    before_action :require_no_user!, only: [:new, :create]

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password])
        if @user
           login_user!(@user)
            redirect_to user_url(@user) 
        else
            flash.now[:errors] = ["Ya don goofed"]
            render :new
        end

    end

    def destroy
        logout_user
        redirect_to new_session_url #or render :new??
    end

end