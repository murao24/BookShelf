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

#if DEBUG
let testDataBooks = [
    Book(title: "悪の経典", author: "貴志祐介"),
    Book(title: "ホワイトラビット", author: "伊坂幸太郎"),
    Book(title: "夜のピクニック", author: "恩田陸"),
    Book(title: "オー！ファーザー！", author: "伊坂幸太郎"),
    Book(title: "黒と茶の幻想（上）", author: "恩田陸"),
    Book(title: "黒と茶の幻想（下）", author: "恩田陸")
]
#endif
