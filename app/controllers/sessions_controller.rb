# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render Views::Sessions::New.new
  end

  def create
    user = User.find_by(email: params[:email]&.downcase&.strip)

    if user
      session[:user_id] = user.id
      redirect_to collection_path(user), notice: "Welcome back, #{user.name}!"
    else
      flash.now[:error] = "No account found with that email."
      render Views::Sessions::New.new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Logged out."
  end
end
