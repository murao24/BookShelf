//
//  SubmitBookViewModel.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine


class BookViewModel: ObservableObject {

    @Published var repository = BookRepository()

    @Published var title: String = ""
    @Published var author: String = ""
    @Published var rating: Int = 3
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    @Published var review: String = ""
    @Published var isValidated: Bool = false
    @Published var errorMessage: String = ""
    @Published var errorPoint: String = ""

    enum ErrorMessage: String {
        case title = "Please enter the title."
        case author = "Please enter the author."
        case date = "The date is incorrect."
    }

    private var cancellabels = Set<AnyCancellable>()

    init() {

        Publishers.CombineLatest4($title, $author, $start, $end)
            .receive(on: RunLoop.main)
            .map { (title, author, start, end) in
                if title == "" {
                    self.errorPoint = "title"
                    self.errorMessage = ErrorMessage.title.rawValue
                    return false
                } else if author == "" {
                    self.errorPoint = "author"
                    self.errorMessage = ErrorMessage.author.rawValue
                    return false
                } else if start > end {
                    self.errorPoint = "date"
                    self.errorMessage = ErrorMessage.date.rawValue
                    return false
                } else {
                    self.errorPoint = ""
                    self.errorMessage = ""
                    return true
                }
        }
        .assign(to: \.isValidated, on: self)
        .store(in: &cancellabels)

    }

    func submitBook() {
        repository.addBook(Book(title: title, author: author, rating: rating, review: review, start: start, end: end))
    }

    func updateBook(_ bookID: String?) {
        repository.update(Book(id: bookID, title: title, author: author, rating: rating, review: review, start: start, end: end))
    }

}
