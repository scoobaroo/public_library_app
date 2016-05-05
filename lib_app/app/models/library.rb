class Library < ActiveRecord::Base
  has_many :library_users
  has_many :books, through: :library_books, dependent: :destroy
  has_many :library_books
  has_many :users, through: :library_users, dependent: :destroy
end
