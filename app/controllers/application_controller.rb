class ApplicationController < ActionController::API
  before_action :authenticate_user

  def encode_token(payload)
    # TODO Replace with .env variable encoder
    JWT.encode(payload, 'SECRET')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      # { Authorization: 'Bearer <token>' }
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'SECRET', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def admin_user
    if logged_in_user
      user = User.find_by(id: @user.id)
      admin = user.admin?
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def admin?
    !!admin_user
  end

  def admin_or_owner?(object)
    admin? || @user.admin_or_owner?(object)
  end

  def authenticate_user
    render json: { message: 'Forbidden' }, status: :forbidden unless logged_in?
  end

  def authorize_action(object)
    render json: { message: 'Unauthorized' }, status: unauthorized unless admin_or_owner?(object)
  end

end
