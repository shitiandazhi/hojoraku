class Public::FavoritesController < ApplicationController

  def create
    @grant = Grant.find(params[:grant_id])
    favorite = current_user.favorites.new(grant_id: @grant.id)
    favorite.save
  end

  def destroy
    @grant = Grant.find(params[:grant_id])
    favorite = current_user.favorites.find_by(grant_id: @grant.id)
    favorite.destroy
  end
end
