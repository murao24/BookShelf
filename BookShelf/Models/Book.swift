//
//  Book.swift
//  BookShelf
//
//  Created by 村尾慶伸 on 2020/07/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Book: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var author: String
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

