class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    if user == current_user
      render json: { error: 'You cannot follow yourself.' }, status: :unprocessable_entity
    else
      current_user.follow user
      render json: user
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  rescue ActiveRecord::RecordNotUnique
    render json: { error: 'You are already following that user.' }, status: :unprocessable_entity
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow user
    render json: user
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
