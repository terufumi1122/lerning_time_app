class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      # log_in user
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'You\'re logged in!!'
    else
      flash.now[:danger] = 'ミスってまっせー'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You\'re logged out!!'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
