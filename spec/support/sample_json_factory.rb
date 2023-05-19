# frozen_string_literal: true

require 'json'

class SampleJsonFactory
  def self.books_sample(authors: 2, books: 10)
    JSON.dump(
      {
        authors: authors.times.map do |author_index|
          {
            name: "Author#{author_index+1} Surname",
            books: books.times.map do |book_index|
              {
                title: "Book Number #{book_index+1}",
                isbn13: "9783161#{book_index.to_s.rjust(6, '0')}"
              }
            end
          }
        end
      }
    )
  end
end
