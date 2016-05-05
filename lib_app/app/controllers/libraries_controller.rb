class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    render :index
  end
  def new
    if current_user
      @library = Library.new
      render :new
    else
      flash[:notice]="You are not authorized to create libraries!"
      redirect_to libraries_path
    end
  end
  def create
    library_params = params.require(:library).permit(:name, :floor_count, :floor_area)
    @library = Library.create(library_params)
    redirect_to libraries_path
  end
  def show
    @library = Library.find(params[:id])
    @books = @library.books
    render :show
  end
  def edit
    if current_user
      @library = Library.find(params[:library_id])
      render :edit
    else
      flash[:notice]="You are not authorized to edit libraries!"
      redirect_to libraries_path
    end
  end
  def update
    @library = Library.find(params[:library_id])
    @library.update(library_params)
    flash[:notice]="Library Succesfully Updated!"
    redirect_to library_path(@library)
  end
  def destroy
    @library = Library.find(params[:library_id])
    if current_user
      @library.destroy
      redirect_to libraries_path
    else
      flash[:notice]="You are not authorized to delete libraries!"
      redirect_to libraries_path
    end
  end
  private
  def library_params
    params.require(:library).permit(:name, :floor_count, :floor_area)
  end
  def book_params
    params.require(:book).permit(:title,:author,:releasedate)
  end
end
