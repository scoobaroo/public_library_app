class BooksController < ApplicationController
  def show
    @library = Library.find(params[:library_id])
    @books = @library.books
    @book = Library.find(params[:book_id])
    render :show
  end
end
