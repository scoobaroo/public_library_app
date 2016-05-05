class LibraryBooksController < ApplicationController
  def index
    @library = Library.find(params[:library_id])
    @books = @library.books
    render :index
  end
  def create
    @book = Book.create(book_params)
    @library = Library.find(params[:library_id])
    @library.books.push(@book)
    redirect_to
  end
  def show
    @library = Library.find(params[:library_id])
    @books = @library.books
    # @book = Book.find(params[:book_id])
    render :show
  end
  def new
    @book = Book.new
    @library  =  Library.find(params[:library_id])
    if current_user
      render :new
    else
      flash[:notice]="You are not authenticated to create books for this library!"
      redirect to library_path(@library)
    end
  end
  def create
    @library = Library.find(params[:library_id])
    @book = Book.create(book_params)
    @library.books << @book
    redirect_to library_path(@library)
  end
  def update
    @book = Book.find(params[:book_id])
    @book.update(book_params)
    @library = Library.find(params[:library_id])
    flash[:notice]="Book succesfully updated!"
    redirect_to library_path(@library)
  end
  def edit
    @library = Library.find(params[:library_id])
    @book = Book.find(params[:book_id])
    if current_user
      render :edit
    else
      flash[:notice]="You are not authorized to edit books!"
      redirect_to library_path(@library)
    end
  end
  def destroy
    @library = Library.find(params[:library_id])
    if current_user
      @book = Book.find(params[:book_id])
      @library.books.destroy(@book)
      flash[:notice]="Succesfully deleted Book!"
      redirect_to library_path(@library)
    else
      flash[:notice]="You are not authorized to delete Books!"
      redirect_to library_path(@library)
    end
  end
  private
  def book_params
    params.require(:book).permit(:title,:author,:releasedate)
  end
end
