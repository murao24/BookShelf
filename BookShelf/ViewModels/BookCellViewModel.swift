//
//  BookCellViewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/06.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class BookCellViewModel: ObservableObject, Identifiable {

    @Published var book: Book
    var id: String = ""

    private var cancellable = Set<AnyCancellable>()

    init(book: Book) {
        self.book = book

        // id に保持
        $book
            .map { book in
                book.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
    }

}
