class UsersController < ApplicationController
  before_action :authenticate_user, only: [:auto_login]

  def create
    @user = User.create(create_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { message: "Invalid email or password " }, status: 422
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: 200
      else
        render json: { message: 'Invalid email or password' }, status: 401
      end
    else
      render json: { message: "Incorrect email or password" }, status: 401
    end
  end

  def auto_login
    render json: @user
  end

  private

  def create_params
    params.require(:user).permit(:email, :password, :email_confirmation, :tos, :gender, :birthday)
  end
end
