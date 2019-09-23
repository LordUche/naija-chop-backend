class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :recipes]

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def following
    render json: @user.following
  end

  def followers
    render json: @user.followers
  end

  def recipes
    render json: @user.recipes
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
