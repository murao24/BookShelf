//
//  SubmitBookViewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine


class SubmitBookViewModel: ObservableObject {

    @Published var repository = BookRepository()

    @Published var title: String = ""
    @Published var author: String = ""
    @Published var rating: Int = 3
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    @Published var reviews: String = ""
    @Published var isValidated: Bool = false

    private var cancellabels = Set<AnyCancellable>()

    init() {

        Publishers.CombineLatest4($title, $author, $start, $end)
            .receive(on: RunLoop.main)
            .map { (title, author, start, end) in
                if title == "" {
                    return false
                } else if author == "" {
                    return false
                } else if start > end {
                    return false
                } else {
                    return true
                }
        }
        .assign(to: \.isValidated, on: self)
        .store(in: &cancellabels)

    }


    func submitBook() {
        repository.addBook(Book(title: title, author: author, rating: rating, reviews: reviews, start: start, end: end))
    }

}
