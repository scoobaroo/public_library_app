class Book < ActiveRecord::Base
  belongs_to :library
  belongs_to :library_book
end
