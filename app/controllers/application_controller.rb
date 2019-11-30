class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :data
  helper_method :current_user
  # before_action :login_required

  def data
    @today = Date.today
    if @current_user
      @user_records = Record.where(user_id: @current_user[:id])

      @daily_total = @user_records.where(created_at: @today.all_day).sum(:lap_time) /60
      @weekly_total = @user_records.where(created_at: @today.all_week).sum(:lap_time) /60
      @monthly_total = @user_records.where(created_at: @today.all_month).sum(:lap_time) /60
      @grand_total = @user_records.sum(:lap_time) / 60
    end
  end

  private

  # def set_locale
  #   I18n.locale = current_user&.locale || :ja
  # end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # def login_required
  #   redirect_to login_path unless current_user
  # end

end
