class FavoritesController < ApplicationController
  def create
  #redirect_back(fallback_location: root_path)
  @book = Book.find(params[:book_id])
    if !Favorite.find_by(book_id: params[:book_id], user_id:current_user.id).present?
      @favorite = current_user.favorites.new(:book_id => params[:book_id])
      @favorite.save
    end
  end

  def destroy
  @book = Book.find(params[:book_id])
  @favorite = current_user.favorites.find_by(book_id: @book.id)
  @favorite.destroy
  #redirect_back(fallback_location: root_path)
  end

end