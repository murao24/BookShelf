//
//  SearchedBook.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/07.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct SearchedBook: Identifiable, Hashable {
    var id: String
    var title: String
    var authors: String
    var description: String
    var imageURL: String
    var previewLink: String
}
