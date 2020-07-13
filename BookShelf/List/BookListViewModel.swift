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
        
    }

    func deleteBook(_ indexSet: IndexSet) {
        if let indexSetFirst = indexSet.first {
            let id = bookCellViewModels[indexSetFirst].book.id
            if let id = id {
                bookRepository.deleteBook(bookID: id)
            }
        }
    }

}
