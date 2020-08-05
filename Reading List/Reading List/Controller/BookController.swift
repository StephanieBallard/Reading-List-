//
//  BookController.swift
//  Reading List
//
//  Created by Stephanie Ballard on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    var readingListURL: URL? {
        let fileManger = FileManager.default
        
        guard let documentsDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents Directory not found.")
            return nil
        }
        
        let booksURL = documentsDirectory.appendingPathComponent("ReadingList")
                                         .appendingPathExtension("plist")
        return booksURL
    }
    
    func saveToPersistentStore() {
        do {
            let booksData = try PropertyListEncoder().encode(books)
            guard let booksURL = readingListURL else { return }
            print("Writing to documents directory")
            try booksData.write(to: booksURL)
        } catch {
            print("Unable to save settings to documents: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let booksURL = readingListURL else { return }
            let booksData = try Data(contentsOf: booksURL)
            let books = try PropertyListDecoder().decode([Book].self, from: booksData)
            self.books = books
            print(books.count)
        } catch {
            print("Error loading books from documents: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let updateRead = books.firstIndex(of: book) else { return }
        books[updateRead].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateBookTitleAndReasonToRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = book.title
        books[index].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter ({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter ({ $0.hasBeenRead == false })
    }
    
    func update(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        var scratch = book
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(scratch, at: index)
        saveToPersistentStore()
    }
}
