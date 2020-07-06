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
    @Published var bookCellViewModels = [BookCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.bookCellViewModels = testDataBooks.map { book in
            BookCellViewModel(book: book)
        }
    }

    func submitBook(book: Book) {
        let bookVM = BookCellViewModel(book: book)
        self.bookCellViewModels.append(bookVM)
    }

}
