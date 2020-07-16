//
//  BookListViewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/06.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
    @Published var bookRepository = BookRepository()
    @Published var bookCellViewModels = [BookCellViewModel]()
    @Published var sortName: String = ""

    let userDefaults = UserDefaults.standard

    private var cancellables = Set<AnyCancellable>()

    init() {
        bookRepository.$books
            .map { books in
                books.map { book in
                    BookCellViewModel(book: book)
                }
        }
        .assign(to: \.bookCellViewModels, on: self)
        .store(in: &cancellables)

        sortName = userDefaults.object(forKey: "sortName") as! String
    }

    func deleteBook(_ bookID: String?) {
        if let bookID = bookID {
            bookRepository.deleteBook(bookID: bookID)
        }
    }

    func sortBook(sortName: String) {
        userDefaults.set(sortName, forKey: "sortName")
        self.sortName = userDefaults.object(forKey: "sortName") as! String
        bookRepository.loadData()
    }

}
