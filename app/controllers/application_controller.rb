class ApplicationController < ActionController::API
  before_action :authorize_user

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
  
  def logged_in?
    !!logged_in_user
  end

  def authorize_user
    render json: { message: 'Unauthorized' }, status: :unauthorized unless logged_in?
  end
end
