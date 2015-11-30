class BooksController < ApplicationController
  def index
    @books = Book.order(ranked: :desc)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create(book_params)
    redirect_to book_path(book)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def upvote
    book = Book.find(params[:id])
    book.ranked += 1
    book.save
    redirect_to book_path(book)
  end

  private

  def book_params
    params.require(:book).permit([:name, :author, :description])
  end
end
