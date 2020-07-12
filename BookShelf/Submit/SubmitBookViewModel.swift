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

    @Published var title: String = ""
    @Published var author: String = ""
    @Published var rating: Int = 3
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    @Published var reviews: String = ""
    @Published var isValidated: Bool = false
    @Published var errorMessage: String = ""

    private var cancellables: Set<AnyCancellable> = []

    init() {
        Publishers.CombineLatest($title, $author, $start, $end)
            .receive(on: RunLoop.main)
            .map { (title, author, start, end) in
                return title.count > 0 && author.count > 0 && start < end
        }
        .assign(to: \.isValidated, on: self)
        .store(in: &cancellables)
    }


    enum ErrorMessage: String {
        case title = "Please enter the title."
        case author = "Please enter the author."
        case date = "There is a discrepancy in the dates."
    }

}
