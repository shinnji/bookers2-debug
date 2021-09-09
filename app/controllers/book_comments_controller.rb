class BookCommentsController < ApplicationController
    def create
 	    @book = Book.find(params[:book_id])
		  @book_comment = BookComment.new(comment_params)
		  @book_comment.book_id = @book.id
		  @book_comment.user_id = current_user.id
		  @book_comment.save

      @user = @book.user
      @book_new = Book.new
      @book_comment = BookComment.new
		  render 'book_comments/create'
	  end

    def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy

    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
    render 'book_comments/create'
    end

  private
  def comment_params
    params.require(:book_comment).permit(:content)
  end
end

