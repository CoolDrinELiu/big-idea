module ApiHelpers
  def authenticate_user_from_token!
    # @user = Customer.find_by_email(request.headers["X-Api-Email"].presence)
    # if @user.blank? || @user.auth_token != request.headers["X-Api-Token"]
    #   error!({result: false, msg: "401 Unauthorized"}, 401)
    # end
  end

  def auth_validate_for_booking!
    header_email_present_and_valid = request.headers["X-Api-Email"].present? && request.headers["X-Api-Email"] != "null" && request.headers["X-Api-Email"] != "undefined"
    if header_email_present_and_valid
      @user = Customer.find_by_email(request.headers["X-Api-Email"].presence)
      error!({result: false, msg: "401 Unauthorized"}, 401) if @user&.auth_token != request.headers["X-Api-Token"]
    end
  end

end
