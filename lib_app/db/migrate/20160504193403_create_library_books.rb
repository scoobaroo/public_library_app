class CreateLibraryBooks < ActiveRecord::Migration
  def change
    create_table :library_books do |t|
      t.references :book, index: true, foreign_key: true
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
